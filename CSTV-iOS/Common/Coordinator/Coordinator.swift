//
//  Coordinator.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var isCompleted: (() -> Void)? { get set }
    
    func start()
}

extension Coordinator {
    func start(coordinator: Coordinator) {
        coordinator.isCompleted = { [weak self, weak coordinator] in
            if let coordinator = coordinator {
                self?.free(coordinator: coordinator)
            }
        }
        
        self.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func free(coordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
    }
    
    func freeAllChildCoordinatorsWith<T>(type: T.Type) {
        self.childCoordinators = self.childCoordinators.filter { $0 is T == false }
    }
    
    func freeAllChildCoordinators() {
        self.childCoordinators.removeAll()
    }
}

protocol NavigationCoordinator: Coordinator {
    var rootViewController: UINavigationController { get }
}
