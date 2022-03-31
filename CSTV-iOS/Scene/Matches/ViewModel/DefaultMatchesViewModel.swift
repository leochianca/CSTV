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
            let matchesSorted = matches.sorted { $0.status > $1.status }
            self?.matches.value = matchesSorted
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
        self.matchesRepository.getMatches()
    }
    
    func refreshMatches() {
        self.matchesRepository.refresh()
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
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM, HH:mm"
            dateFormatter.timeZone = .autoupdatingCurrent
            dateFormatter.locale = .autoupdatingCurrent
            time = dateFormatter.string(from: match.date ?? Date())
        }
        
        self.coordinator?.goToDetails(teams: teams, leagueName: match.league.name, time: time)
    }
}
