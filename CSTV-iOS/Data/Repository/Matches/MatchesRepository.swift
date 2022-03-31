//
//  MatchesRepository.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

enum MatchesRepositoryError: Error, Equatable {
    case generic(errorMessage: String)
}

typealias MatchesRepositoryState = RepositoryState<MatchesRepositoryError>

protocol MatchesRepository {
    var matches: Observable<[Matches]> { get }
    var state: Observable<MatchesRepositoryState> { get }
    
    func getMatches()
    func refresh()
}
