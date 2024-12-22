//
//  AppCoordinator.swift
//  TabBarProject
//
//  Created by Kseniia Piskun on 19.12.2024.
//

import UIKit

class AppCoordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let splashViewModel = SplashViewModel { [weak self] in
            self?.showTabBar()
        }
        let splashView = SplashView(viewModel: splashViewModel)
        window.rootViewController = splashView
        window.makeKeyAndVisible()
    }

    private func showTabBar() {
        let tabBarController = TabBarController()

        let firstViewModel = FirstTabViewModel()
        let firstView = FirstTabView(viewModel: firstViewModel)
        firstView.tabBarItem = UITabBarItem(title: "List", image: nil, tag: 0)

        let secondViewModel = SecondTabViewModel(firstTabViewModel: firstViewModel)
        let secondView = SecondTabView(viewModel: secondViewModel)
        secondView.tabBarItem = UITabBarItem(title: "Favorites", image: nil, tag: 1)

        tabBarController.viewControllers = [firstView, secondView]
        window.rootViewController = tabBarController
    }
}
