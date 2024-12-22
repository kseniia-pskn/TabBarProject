//
//  SecondTabView.swift
//  TabBarProject
//
//  Created by Kseniia Piskun on 19.12.2024.
//

import UIKit
import RxSwift
import RxCocoa

class SecondTabView: UIViewController {
    private let viewModel: SecondTabViewModel
    private let disposeBag = DisposeBag()
    
    private let tableView = UITableView()
    private let removeAllButton = UIButton(type: .system)

    init(viewModel: SecondTabViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        // Налаштування таблиці
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.setEditing(true, animated: false) // Дозволяємо редагування
        view.addSubview(tableView)
        
        // Налаштування кнопки
        removeAllButton.setTitle("Remove All", for: .normal)
        removeAllButton.isHidden = true
        view.addSubview(removeAllButton)
        
        // Layout
        tableView.translatesAutoresizingMaskIntoConstraints = false
        removeAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: removeAllButton.topAnchor, constant: -10),
            
            removeAllButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            removeAllButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            removeAllButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupBindings() {
        // Зв’язок таблиці з даними
        viewModel.favoriteItems
            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) { index, item, cell in
                cell.textLabel?.text = item.title
            }
            .disposed(by: disposeBag)
        
        // Видалення елемента через свайп
        tableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let item = self.viewModel.favoriteItems.value[indexPath.row]
                self.viewModel.removeFromFavorites(id: item.id)
            })
            .disposed(by: disposeBag)
        
        // Показ/приховування кнопки "Remove All"
        viewModel.favoriteItems
            .map { $0.isEmpty }
            .bind(to: removeAllButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        // Масове видалення
        removeAllButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let ids = self.viewModel.favoriteItems.value.map { $0.id }
                self.viewModel.removeAllFromFavorites(ids: ids)
            })
            .disposed(by: disposeBag)
    }
}
