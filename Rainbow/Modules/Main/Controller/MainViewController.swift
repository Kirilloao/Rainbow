//
//  ViewController.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 12.11.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
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
    @objc private func settingsAction() {
        
    }
    
    @objc private func rulesAction() {
        
    }
    
    @objc private func newGameAction() {
        
    }
    
    @objc private func statAction() {
        
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
        mainView.statTarget(self, action: #selector(statAction))
        mainView.settingsTarget(self, action: #selector(settingsAction))
        mainView.rulesTarget(self, action: #selector(rulesAction))
    }
}

