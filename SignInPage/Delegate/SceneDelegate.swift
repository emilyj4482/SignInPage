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
        
        // 모든 controller에서 같은 core data context를 바라보도록 단일 객체 주입
        let repository: UserRepository = .init()
        window.rootViewController = UINavigationController(rootViewController: SignInViewController(repository: repository))
        
        window.makeKeyAndVisible()
        self.window = window
    }
}
