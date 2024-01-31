//
//  ApplicationCoordinator.swift
//  Nitrix
//
//  Created by Misha Vrana on 29.01.2024.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    
    var childCoordinators = [Coordinator]()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let mainCoordinator = MainCoordinator()
        childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
        self.window.rootViewController = mainCoordinator.rootViewController
    }
}
