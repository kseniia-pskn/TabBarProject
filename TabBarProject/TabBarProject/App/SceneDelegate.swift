//
//  SceneDelegate.swift
//  TabBarProject
//
//  Created by Kseniia Piskun on 19.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Створюємо вікно
        let window = UIWindow(windowScene: windowScene)

        // Ініціалізуємо SplashViewModel
        let splashViewModel = SplashViewModel { [weak self] in
            self?.showMainApp()
        }

        // Встановлюємо SplashView як rootViewController
        let splashView = SplashView(viewModel: splashViewModel)
        window.rootViewController = splashView

        // Робимо вікно видимим
        window.makeKeyAndVisible()
        self.window = window
    }

    // Метод для переходу до головного екрану
    private func showMainApp() {
        guard let window = self.window else { return }

        let tabBarController = TabBarController()

        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = tabBarController
        }, completion: nil)
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
