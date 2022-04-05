//
//  DefaultMatchesViewModel.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

class DefaultMatchesViewModel: MatchesViewModel {
    private let matchesRepository: MatchesRepository
    let matches: Observable<[Matches]> = .init([])
    let finishLoading: Observable<Bool> = .init(false)
    
    weak var coordinator: MainCoordinator?
    
    init(coordinator: MainCoordinator, matchesRepository: MatchesRepository = DefaultMatchesRepository()) {
        self.coordinator = coordinator
        self.matchesRepository = matchesRepository
        self.bind(to: matchesRepository)
        self.getMatches()
    }
    
    private func bind(to matchesRespository: MatchesRepository) {
        matchesRepository.matches.addAndNotify(observer: self) { [weak self] matches in
            self?.matches.value = matches
        }
        matchesRespository.state.addAndNotify(observer: self) { [weak self] state in
            self?.didLoadMatches(state: state)
        }
    }
    
    private func didLoadMatches(state: MatchesRepositoryState) {
        self.finishLoading.value = state == .loaded
    }
    
    func getMatches() {
        self.matchesRepository.getRunningMatches()
        self.matchesRepository.getUpcomingMatches()
    }
    
    func refreshMatches() {
        self.matchesRepository.refresh()
    }
    
    func pagination(indexPath: IndexPath) {
        if indexPath.row == self.matches.value.count - 1 {
            self.matchesRepository.getUpcomingMatches()
        }
    }
    
    func goToDetails(match: Matches) {
        self.coordinator?.goToDetails(match: match)
    }
}
