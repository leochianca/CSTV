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
    
    func goToDetails(teams: [Teams], leagueName: String, time: String) {
        let matchesDetailsViewController = MatchesDetailsViewController(teams: teams, leagueName: leagueName, time: time)
        let matchesDetailsViewModel: MatchesDetailsViewModel = DefaultMatchesDetailsViewModel(coordinator: self)
        matchesDetailsViewController.bind(to: matchesDetailsViewModel)
        matchesDetailsViewController.modalPresentationStyle = .fullScreen
        self.rootViewController.pushViewController(matchesDetailsViewController, animated: true)
    }
    
    func goBack() {
        self.rootViewController.popViewController(animated: true)
    }
}
