//
//  MainCoordinator.swift
//  Nitrix
//
//  Created by Misha Vrana on 29.01.2024.
//

import Foundation
import SwiftUI

class MainCoordinator: Coordinator {
    
    let rootViewController: UITabBarController
    
    var childCoordinators = [Coordinator]()
    
    init() {
        self.rootViewController = UITabBarController()
        rootViewController.tabBar.isTranslucent = true
        rootViewController.tabBar.backgroundColor = .systemGray6
    }
    
    func start() {
        let movieListCoordinator = MovieListCoordinator()
        movieListCoordinator.start()
        childCoordinators.append(movieListCoordinator)
        let moviewViewController = movieListCoordinator.rootViewController
        moviewViewController.tabBarItem = UITabBarItem(title: "Movies List", image: UIImage(systemName: "movieclapper"), selectedImage: UIImage(systemName: "movieclapper.fill"))
        
        let favoritesCoordinator = FavoritesCoordinator()
        favoritesCoordinator.start()
        childCoordinators.append(favoritesCoordinator)
        let favoritesViewController = favoritesCoordinator.rootViewController
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        
        rootViewController.viewControllers = [moviewViewController, favoritesViewController]
    }
}
