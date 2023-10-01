//
//  SceneDelegate.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 30/09/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        if AuthManager.shared.isSignedIn {
            window.rootViewController = TabBarViewController()
        } else {
            let navVC = UINavigationController(rootViewController: WelcomeViewController())
            navVC.navigationBar.prefersLargeTitles = true
            navVC.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
            window.rootViewController = navVC

        }
        window.makeKeyAndVisible()
        self.window = window
    }

    // For spotify authorization and authentication flow
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }
}
