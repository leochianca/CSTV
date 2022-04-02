//
//  DefaultTeamsRepository.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

class DefaultTeamsRepository: TeamsRepository {
    private let dataSource: TeamsDataSource
    private let totalPages: Int = 41 // Max number of team pages
    let teams: Observable<[Teams]> = .init([])
    let state: Observable<TeamsRepositoryState> = .init(.idle)
    
    init(dataSource: TeamsDataSource = RemoteTeamsDataSource()) {
        self.dataSource = dataSource
    }
    
    func getTeams(match: Matches) {
        self.state.value = .loading
        for page in 1...self.totalPages {
            self.dataSource.getAllTeams(page: page) { [weak self] result in
                switch result {
                case .success(let teams):
                    for team in teams {
                        if team.id == match.opponents[0].opponent.id || team.id == match.opponents[1].opponent.id {
                            self?.teams.value.append(team)
                            if self?.teams.value.count == 2 {
                                self?.state.value = .loaded
                                return
                            }
                        }
                    }
                case .failure(let error):
                    self?.state.value = .error(.generic(errorMessage: error.message))
                }
            }
        }
    }
}
