//
//  TeamsRepository.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

enum TeamsRepositoryError: Error, Equatable {
    case generic(errorMessage: String)
}

typealias TeamsRepositoryState = RepositoryState<TeamsRepositoryError>

protocol TeamsRepository {
    var teams: Observable<[Teams]> { get }
    var state: Observable<TeamsRepositoryState> { get }
    
    func getTeams(match: Matches)
}
