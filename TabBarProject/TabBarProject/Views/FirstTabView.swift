//
//  FirstTabView.swift
//  TabBarProject
//
//  Created by Kseniia Piskun on 19.12.2024.
//

import UIKit
import RxSwift
import RxCocoa

class FirstTabView: UIViewController {
    private let viewModel: FirstTabViewModel
    private let disposeBag = DisposeBag()
    private let tableView = UITableView()
    private let selectAllButton = UIButton(type: .system)

    init(viewModel: FirstTabViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All Items"
        view.backgroundColor = .white
        viewModel.loadData()
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        // Налаштування таблиці
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.allowsMultipleSelection = true
        view.addSubview(tableView)

        // Налаштування кнопки
        selectAllButton.setTitle("Select All", for: .normal)
        view.addSubview(selectAllButton)

        // Layout
        tableView.translatesAutoresizingMaskIntoConstraints = false
        selectAllButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: selectAllButton.topAnchor, constant: -10),

            selectAllButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            selectAllButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectAllButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func bindViewModel() {
        // Підключаємо список елементів до таблиці
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) { index, item, cell in
                cell.textLabel?.text = item.title
                cell.accessoryType = self.viewModel.selectedItems.value.contains(item.id) ? .checkmark : .none
            }
            .disposed(by: disposeBag)

        // Обробка вибору елемента
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let item = self?.viewModel.items.value[indexPath.row]
                if let id = item?.id {
                    self?.viewModel.toggleSelection(for: id)
                }
            })
            .disposed(by: disposeBag)

        // Обробка скасування вибору
        tableView.rx.itemDeselected
            .subscribe(onNext: { [weak self] indexPath in
                let item = self?.viewModel.items.value[indexPath.row]
                if let id = item?.id {
                    self?.viewModel.toggleSelection(for: id)
                }
            })
            .disposed(by: disposeBag)

        // Оновлення таблиці при зміні selectedItems
        viewModel.selectedItems
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)

        // Логіка кнопки "Select All"
        selectAllButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if self.viewModel.areAllSelected() {
                    self.viewModel.clearSelection()
                    self.selectAllButton.setTitle("Select All", for: .normal)
                } else {
                    self.viewModel.selectAll()
                    self.selectAllButton.setTitle("Deselect All", for: .normal)
                }
            })
            .disposed(by: disposeBag)

        // Динамічне оновлення назви кнопки
        viewModel.selectedItems
            .map { [weak self] _ in self?.viewModel.areAllSelected() ?? false }
            .subscribe(onNext: { [weak self] allSelected in
                self?.selectAllButton.setTitle(allSelected ? "Deselect All" : "Select All", for: .normal)
            })
            .disposed(by: disposeBag)
    }
}

extension FirstTabView: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Отримуємо ідентифікатор елемента
            let item = viewModel.items.value[indexPath.row]

            // Додаємо його до вибраних
            viewModel.toggleSelection(for: item.id)

            // Оновлюємо рядок
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }

        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            // Отримуємо ідентифікатор елемента
            let item = viewModel.items.value[indexPath.row]

            // Видаляємо його з вибраних
            viewModel.toggleSelection(for: item.id)

            // Оновлюємо рядок
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
