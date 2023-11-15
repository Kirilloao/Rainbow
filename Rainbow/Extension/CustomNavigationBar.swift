//
//  CustomNavigationBar.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 14.11.2023.
//

import UIKit

final class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        configureNavigationBarAppearance()
    }
    
    // MARK: - UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        let isListViewController = viewController is MainViewController
        setNavigationBarHidden(isListViewController, animated: true)
        
        if !(viewController is MainViewController) {
            configureBackButton(for: viewController)
        }
    }
    
    // MARK: - Private Actions
    @objc private func goBack() {
        popToRootViewController(animated: true)
    }
    
    // MARK: - Private Methods
    private func configureBackButton(for viewController: UIViewController) {
        let backButton = UIBarButtonItem(
            image: UIImage(named: "backButton"),
            style: .plain,
            target: self,
            action: #selector(goBack))
        
        backButton.tintColor = .black
        viewController.navigationItem.leftBarButtonItem = backButton
        navigationBar.prefersLargeTitles = false
    }
    
    private func configureNavigationBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
         navBarAppearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 29)]
         navigationBar.standardAppearance = navBarAppearance
    }
}
