//
//  ViewController.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 12.11.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    private let appState = AppState()
    
    // MARK: - Private UI Properties
    private let mainView = MainView()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isEnabled = !(appState.getGame() == nil)
        mainView.toggleResumeButton(isEnabled: isEnabled)
    }
    
    // MARK: - Private Actions
    //Settings button tapped
    @objc private func settingsAction() {
        let vc = SettingsViewController(dataSource: appState)
        navigateToScreen(vc)
    }
    //Rules button tapped
    @objc private func rulesAction() {
        navigateToScreen(RulesViewController())
    }
    //New game button tapped
    @objc private func newGameAction() {
        let vc = GameViewController(dataSource: appState)
        navigateToScreen(vc)
    }
    //Statistic button tapped
    @objc private func statisticAction() {
        let resultsModel = ResultsModel(dataSource: appState)
        let vc = ResultsViewController(model: resultsModel)
        navigateToScreen(vc)
    }
    
    @objc private func resumeGame() {
        let vc = GameViewController(dataSource: appState, resume: true)
        navigateToScreen(vc)
    }
    
    // MARK: - Private Methods
    private func navigateToScreen(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupView() {
        view.addSubviews(mainView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func addTargets() {
        mainView.addTarget(to: .newgame, target: self, action: #selector(newGameAction))
        mainView.addTarget(to: .statistic, target: self, action: #selector(statisticAction))
        mainView.addTarget(to: .settings, target: self, action: #selector(settingsAction))
        mainView.addTarget(to: .rules, target: self, action: #selector(rulesAction))
        mainView.addTarget(to: .resume, target: self, action: #selector(resumeGame))
    }
}
