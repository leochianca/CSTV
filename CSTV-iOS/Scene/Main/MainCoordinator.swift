//
//  MainCoordinator.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation
import UIKit

class MainCoordinator: NavigationCoordinator {
    var isCompleted: (() -> Void)?
    var rootViewController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init() {
        self.rootViewController = UINavigationController()
    }
    
    func start() {
        let matchesViewController = MatchesViewController()
        self.rootViewController.modalPresentationStyle = .fullScreen
        self.rootViewController.isNavigationBarHidden = true
        self.rootViewController.viewControllers = [matchesViewController]
    }
}
