//
//  SceneDelegate.swift
//  SignInPage
//
//  Created by EMILY on 12/05/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = .systemBackground
        window.rootViewController = UINavigationController(rootViewController: StartViewController())
        window.makeKeyAndVisible()
        self.window = window
    }
}
