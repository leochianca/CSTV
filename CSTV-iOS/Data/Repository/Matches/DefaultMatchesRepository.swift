//
//  DefaultMatchesRepository.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

class DefaultMatchesRepository: MatchesRepository {
    private let dataSource: MatchesDataSource
    private let totalPages: Int = 20 // Arbitrary max number of matches pages
    let matches: Observable<[Matches]> = .init([])
    let state: Observable<MatchesRepositoryState> = .init(.idle)
    
    init(dataSource: MatchesDataSource = RemoteMatchesDataSource()) {
        self.dataSource = dataSource
    }
    
    func refresh() {
        self.matches.value.removeAll()
        self.getMatches()
    }
    
    func getMatches() {
        self.state.value = .loading
        for page in 1...self.totalPages {
            self.dataSource.getAllMatches(page: page) { [weak self] result in
                switch result {
                case .success(let matches):
                    // Filtering unfinished matches
                    var matchesFiltered: [Matches] = []
                    for match in matches {
                        if match.status == "running" || match.status == "not_started" {
                            if match.opponents.count == 2 {
                                matchesFiltered.append(match)
                            }
                        }
                    }
                    self?.matches.value.append(contentsOf: matchesFiltered)
                    if page == self?.totalPages {
                        self?.state.value = .loaded
                    }
                case .failure(let error):
                    self?.state.value = .error(.generic(errorMessage: error.message))
                }
            }
        }
    }
}
