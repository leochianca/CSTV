//
//  DefaultMatchesDetailsViewModel.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

class DefaultMatchesDetailsViewModel: MatchesDetailsViewModel {
    private let teamsRepository: TeamsRepository
    weak var coordinator: MainCoordinator?
    let teams: Observable<[Teams]?> = .init(nil)
    let state: Observable<TeamsRepositoryState> = .init(.idle)
    let finishLoading: Observable<Bool> = .init(false)
    let match: Observable<Matches?> = .init(nil)
    
    init(coordinator: MainCoordinator, teamsRepository: TeamsRepository = DefaultTeamsRepository(), match: Matches) {
        self.coordinator = coordinator
        self.teamsRepository = teamsRepository
        self.match.value = match
        self.bind(to: teamsRepository)
        self.getTeams()
    }
    
    private func bind(to teamsRepository: TeamsRepository) {
        teamsRepository.teams.addAndNotify(observer: self) { [weak self] teams in
            self?.teams.value = teams
        }
        teamsRepository.state.addAndNotify(observer: self) { [weak self] state in
            self?.didLoadTeams(state: state)
        }
    }
    
    private func didLoadTeams(state: TeamsRepositoryState) {
        self.finishLoading.value = state == .loaded
    }
    
    func getTeams() {
        guard let match = self.match.value else { return }
        self.teamsRepository.getTeams(match: match)
    }
    
    func goBack() {
        self.coordinator?.goBack()
    }
}
