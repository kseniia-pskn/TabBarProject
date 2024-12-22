//
//  TabBarController.swift
//  TabBarProject
//
//  Created by Kseniia Piskun on 19.12.2024.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabs()
    }
    
    private func setupTabs() {
        // Перший таб: Список елементів
        let firstViewModel = FirstTabViewModel()
        let firstTab = FirstTabView(viewModel: firstViewModel)
        firstTab.tabBarItem = UITabBarItem(
            title: "List",
            image: UIImage(systemName: "list.bullet"),
            tag: 0
        )
        
        // Другий таб: Обрані елементи
        let secondViewModel = SecondTabViewModel(firstTabViewModel: firstViewModel)
        let secondTab = SecondTabView(viewModel: secondViewModel)
        secondTab.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "star"),
            tag: 1
        )
        
        // Інтеграція табів
        viewControllers = [
            UINavigationController(rootViewController: firstTab),
            UINavigationController(rootViewController: secondTab)
        ]
        
        // Передача даних між табами
        firstViewModel.selectedItems
            .subscribe(onNext: { selectedItems in
                let selectedModels = firstViewModel.items.value.filter { selectedItems.contains($0.id) }
                secondViewModel.favoriteItems.accept(selectedModels)
            })
            .disposed(by: firstViewModel.disposeBag)
    }
}
