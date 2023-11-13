//
//  ViewController.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 12.11.2023.
//

import UIKit

class MainViewController: UIViewController {

    private let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        addTargets()
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
        mainView.newGameTarget(self, action: #selector(newGameAction))
        mainView.statTarget(self, action: #selector(statAction))
        mainView.settingsTarget(self, action: #selector(settingsAction))
        mainView.rulesTarget(self, action: #selector(rulesAction))
    }
    
    @objc private func settingsAction() {
        
    }
    
    @objc private func rulesAction() {
        
    }
    
    @objc private func newGameAction() {
        
    }
    
    @objc private func statAction() {
        
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
