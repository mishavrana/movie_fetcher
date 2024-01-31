//
//  SceneDelegate.swift
//  Nitrix
//
//  Created by Misha Vrana on 29.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var applicationCoordinator: ApplicationCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let applicationCoordinator = ApplicationCoordinator(window: window)
            self.applicationCoordinator = applicationCoordinator
            applicationCoordinator.start()
            window.makeKeyAndVisible()
       }
        guard let _ = (scene as? UIWindowScene) else { return }
    }

}

