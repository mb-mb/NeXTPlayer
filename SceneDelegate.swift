//
//  SceneDelegate.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 30/09/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate  {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        //
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        //
    }
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        //
    }
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        //
    }
    

    var window: UIWindow?
    var accessToken: String?
    
    lazy var configuration = SPTConfiguration(clientID: spotifyClientId,
                                              redirectURL: redirectURL)
    
    lazy var appRemote: SPTAppRemote = {
      let appRemote = SPTAppRemote(configuration: self.configuration, logLevel: .debug)
      appRemote.connectionParameters.accessToken = self.accessToken
      appRemote.delegate = self
      return appRemote
    }()
    
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
        print(AuthManager.shared.signInURL?.absoluteString)
    }

    // For spotify authorization and authentication flow
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
             return
         }

         let parameters = appRemote.authorizationParameters(from: url);

         if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
             appRemote.connectionParameters.accessToken = access_token
             self.accessToken = access_token
         } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
             // Show the error
         }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }
    
  
}
