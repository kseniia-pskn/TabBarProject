//
//  FirstTabViewModel.swift
//  TabBarProject
//
//  Created by Kseniia Piskun on 19.12.2024.
//

import RxSwift
import RxCocoa

class FirstTabViewModel {
    let disposeBag = DisposeBag() // Додайте цю властивість

    // Дані для відображення
    let items: BehaviorRelay<[Item]> = .init(value: [])
    let selectedItems: BehaviorRelay<Set<Int>> = .init(value: [])

    // Завантаження даних
    func loadData() {
        let dummyItems = (1...20).map { Item(id: $0, title: "Item \($0)") }
        items.accept(dummyItems)
    }

    func toggleSelection(for id: Int) {
        var updated = selectedItems.value
        if updated.contains(id) {
            updated.remove(id)
        } else {
            updated.insert(id)
        }
        selectedItems.accept(updated)
    }

    func selectAll() {
            let allIDs = Set(items.value.map { $0.id })
            selectedItems.accept(allIDs)
        }
    
    func clearSelection() {
            selectedItems.accept([]) // Очищуємо список вибраних
        }
    
    func areAllSelected() -> Bool {
        return selectedItems.value.count == items.value.count
    }
}
