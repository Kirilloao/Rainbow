//
//  RulesViewController.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 12.11.2023.
//

import UIKit

final class RulesViewController: UIViewController {
    
    // MARK: - Private UI Properties
    private let rulesView = RulesView()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Помощь"
        setViews()
        setupConstraints()
    }
    
    // MARK: - Privaet Methods
    private func setViews() {
        view.backgroundColor = .grayBackgroundColor
        view.addSubview(rulesView)
    }
    
    private func setupConstraints() {
        rulesView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rulesView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            rulesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            rulesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            rulesView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
}



