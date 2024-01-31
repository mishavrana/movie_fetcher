//
//  FavoritesCoordinator.swift
//  Nitrix
//
//  Created by Misha Vrana on 30.01.2024.
//

import Foundation
import UIKit
import SwiftUI

class FavoritesCoordinator: Coordinator {
    var rootViewController = UINavigationController()

    lazy var secondViewController: FavoriteViewController = {
        let vc = FavoriteViewController()
        vc.title = "Favorites"
        vc.showDetailRequest = { [weak self] movie in
            self?.showMovieDetails(movie: movie)
        }
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([secondViewController ], animated: false)
    }
    
    func showMovieDetails(movie: FavoriteMovie) {
        let detailViewController = UIHostingController(rootView: FavoriteMovieDetail(favoriteMovie: movie))
        rootViewController.pushViewController(detailViewController, animated: true)
    }
}
