//
//  ViewController.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 12.11.2023.
//

import UIKit

final class MainViewController: UIViewController {
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
    
    // MARK: - Private Actions
    //Settings button tapped
    @objc private func settingsAction() {
        let vc = SettingsViewController(dataSource: appState)
        navigationController?.pushViewController(vc, animated: true)
    }
    //Rules button tapped
    @objc private func rulesAction() {
        let vc = RulesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    //New game button tapped
    @objc private func newGameAction() {
        let vc = GameViewController(dataSource: appState)
        navigationController?.pushViewController(vc, animated: true)
    }
    //Statistic button tapped
    @objc private func statisticAction() {
        let resultsModel = ResultsModel(dataSource: appState)
        let vc = ResultsViewController(model: resultsModel)
        navigationController?.pushViewController(vc, animated: true)
    }

    
    // MARK: - Private Methods
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
        mainView.newGameTarget(self, action: #selector(newGameAction))
        mainView.statTarget(self, action: #selector(statisticAction))
        mainView.settingsTarget(self, action: #selector(settingsAction))
        mainView.rulesTarget(self, action: #selector(rulesAction))
    }
}

//MARK: - SwiftUI
import SwiftUI
struct Provider_MainViewController : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return MainViewController()
        }
        
        typealias UIViewControllerType = UIViewController
        
        
        let viewController = MainViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<Provider_MainViewController.ContainterView>) -> MainViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: Provider_MainViewController.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<Provider_MainViewController.ContainterView>) {
            
        }
    }
    
}
