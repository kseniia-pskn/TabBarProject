//
//  SplashView.swift
//  TabBarProject
//
//  Created by Kseniia Piskun on 19.12.2024.
//

import UIKit

class SplashView: UIViewController {
    private let viewModel: SplashViewModel
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let loadingLabel = UILabel()

    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startLoading()
    }

    private func setupUI() {
        view.backgroundColor = .white

        // Налаштування Activity Indicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)

        // Налаштування текстового лейбла
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.text = "Loading items..."
        loadingLabel.textAlignment = .center
        loadingLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        loadingLabel.textColor = .darkGray
        view.addSubview(loadingLabel)

        // Layout
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),

            loadingLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func startLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.viewModel.completeSplash()
        }
    }
}

class SplashViewModel {
    let onComplete: () -> Void

    init(onComplete: @escaping () -> Void) {
        self.onComplete = onComplete
    }

    func completeSplash() {
        onComplete()
    }
}
