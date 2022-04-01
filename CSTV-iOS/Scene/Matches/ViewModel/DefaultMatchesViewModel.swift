//
//  DefaultMatchesViewModel.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

class DefaultMatchesViewModel: MatchesViewModel {
    private let matchesRepository: MatchesRepository
    private let teamsRepository: TeamsRepository
    let matches: Observable<[Matches]> = .init([])
    let teams: Observable<[Teams]> = .init([])
    let finishLoading: Observable<Bool> = .init(false)
    
    weak var coordinator: MainCoordinator?
    
    init(coordinator: MainCoordinator, matchesRepository: MatchesRepository = DefaultMatchesRepository(), teamsRepository: TeamsRepository = DefaultTeamsRepository()) {
        self.coordinator = coordinator
        self.matchesRepository = matchesRepository
        self.teamsRepository = teamsRepository
        self.bind(to: matchesRepository, teamsRepository: teamsRepository)
        self.getMatches()
        self.getTeams()
    }
    
    private func bind(to matchesRespository: MatchesRepository, teamsRepository: TeamsRepository) {
        matchesRepository.matches.addAndNotify(observer: self) { [weak self] matches in
            self?.matches.value = matches
        }
        matchesRespository.state.addAndNotify(observer: self) { [weak self] state in
            self?.didLoadMatches(state: state)
        }
        teamsRepository.teams.addAndNotify(observer: self) { [weak self] teams in
            self?.teams.value = teams
        }
    }
    
    private func getTeams() {
        self.teamsRepository.getTeams()
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
        var teams: [Teams] = []
        for team in self.teams.value {
            if team.id == match.opponents[0].opponent.id || team.id == match.opponents[1].opponent.id {
                teams.append(team)
            }
        }
        
        var time: String = ""
        if match.status == "running" {
            time = "AGORA"
        } else {
            guard let matchDate = match.date else { return }
            time = DateFormatter.dateString(initialDate: Date(), endDate: matchDate)
        }
        self.coordinator?.goToDetails(teams: teams, leagueName: match.league.name, time: time)
    }
}
