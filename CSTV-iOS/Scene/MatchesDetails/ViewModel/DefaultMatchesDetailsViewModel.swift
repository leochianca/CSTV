//
//  DefaultMatchesDetailsViewModel.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

class DefaultMatchesDetailsViewModel: MatchesDetailsViewModel {
    weak var coordinator: MainCoordinator?
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    func goBack() {
        self.coordinator?.goBack()
    }
}
