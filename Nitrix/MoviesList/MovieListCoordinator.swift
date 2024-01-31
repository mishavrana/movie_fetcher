//
//  MovieListCoordinator.swift
//  Nitrix
//
//  Created by Misha Vrana on 29.01.2024.
//

import Foundation
import UIKit
import SwiftUI

class MovieListCoordinator: Coordinator {
    var rootViewController = UINavigationController()

    lazy var secondViewController: MovieListViewController = {
        let vc = MovieListViewController()
        vc.title = "Movie List"
        vc.tableViewDelegate.showDetailRequest = { movie in
            self.showMovieDetails(movie: movie)
        }
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([secondViewController ], animated: false)
    }
    
    func showMovieDetails(movie: Movie) {
        let detailViewController = UIHostingController(rootView: MovieDetailView(movie: movie))
        rootViewController.pushViewController(detailViewController, animated: true)
    }
}
