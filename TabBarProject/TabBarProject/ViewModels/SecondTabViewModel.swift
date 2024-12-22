//
//  SecondTabViewModel.swift
//  TabBarProject
//
//  Created by Kseniia Piskun on 19.12.2024.
//

import RxSwift
import RxCocoa

class SecondTabViewModel {
    let favoriteItems = BehaviorRelay<[Item]>(value: [])
    private let firstTabViewModel: FirstTabViewModel

    init(firstTabViewModel: FirstTabViewModel) {
        self.firstTabViewModel = firstTabViewModel
    }

    // Видалити елемент за ідентифікатором
    func removeFromFavorites(id: Int) {
        let updated = favoriteItems.value.filter { $0.id != id }
        favoriteItems.accept(updated)

        // Синхронізувати з FirstTabViewModel
        var selected = firstTabViewModel.selectedItems.value
        selected.remove(id)
        firstTabViewModel.selectedItems.accept(selected)
    }

    // Видалити всі елементи
    func removeAllFromFavorites(ids: [Int]) {
        favoriteItems.accept([])

        // Синхронізувати з FirstTabViewModel
        firstTabViewModel.clearSelection()
    }
}
