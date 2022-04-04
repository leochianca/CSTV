//
//  DefaultMatchesRepository.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

class DefaultMatchesRepository: MatchesRepository {
    private let dataSource: MatchesDataSource
    private let totalPages: Int = 20 // Arbitrary max number of matches pages (API doesn't specify)
    private var page: Int = 0
    private var matchesFiltered: [Matches] = []
    let matches: Observable<[Matches]> = .init([])
    let state: Observable<MatchesRepositoryState> = .init(.idle)
    
    init(dataSource: MatchesDataSource = RemoteMatchesDataSource()) {
        self.dataSource = dataSource
    }
    
    func refresh() {
        self.page = 0
        self.matches.value.removeAll()
        self.matchesFiltered.removeAll()
        self.getRunningMatches()
        self.getUpcomingMatches()
    }
    
    func getRunningMatches() {
        self.dataSource.getRunningMatches { [weak self] result in
            switch result {
            case .success(let runningMatches):
                // Filtering only matches that have the opponents object with 2 opponents (some of the matches object in the API have empty opponents object)120
                for match in runningMatches {
                    if match.opponents.count == 2 {
                        self?.matchesFiltered.append(match)
                    }
                }
            case .failure(let error):
                self?.state.value = .error(.generic(errorMessage: error.message))
            }
        }
    }
    
    func getUpcomingMatches() {
        guard self.page < self.totalPages, self.state.value != .loading else { return }
        
        self.state.value = .loading
        self.page += 1
        
        self.dataSource.getUpcomingMatches(page: self.page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let upComingMatches):
                // Filtering only matches that have the opponents object with 2 opponents (some of the matches object in the API have empty opponents object)
                for match in upComingMatches {
                    if match.opponents.count == 2 {
                        self.matchesFiltered.append(match)
                    }
                }
                self.matches.value.append(contentsOf: self.matchesFiltered)
                self.matches.value.sort { $0.status > $1.status }
                self.matchesFiltered.removeAll()
                self.state.value = .loaded
            case .failure(let error):
                self.state.value = .error(.generic(errorMessage: error.message))
            }
        }
    }
}
