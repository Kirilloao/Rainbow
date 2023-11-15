//
//  SceneDelegate.swift
//  Rainbow
//
//  Created by Kirill Taraturin on 12.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let rootVC = GameViewController()
        let navigationVC = CustomNavigationController(rootViewController: rootVC)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }
}

