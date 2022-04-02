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
    var viewModel: MatchesViewModel?
    
    init() {
        self.rootViewController = UINavigationController()
        self.viewModel = DefaultMatchesViewModel(coordinator: self)
    }
    
    func start() {
        let matchesViewController = MatchesViewController()
        matchesViewController.bind(to: self.viewModel!)
        self.rootViewController.modalPresentationStyle = .fullScreen
        self.rootViewController.isNavigationBarHidden = true
        self.rootViewController.viewControllers = [matchesViewController]
    }
    
    func goToDetails(match: Matches) {
        let matchesDetailsViewController = MatchesDetailsViewController()
        let matchesDetailsViewModel: MatchesDetailsViewModel = DefaultMatchesDetailsViewModel(coordinator: self, match: match)
        matchesDetailsViewController.bind(to: matchesDetailsViewModel)
        matchesDetailsViewController.modalPresentationStyle = .fullScreen
        self.rootViewController.pushViewController(matchesDetailsViewController, animated: true)
    }
    
    func goBack() {
        self.rootViewController.popViewController(animated: true)
    }
}
