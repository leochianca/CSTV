//
//  MatchesDetailsViewModel.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

protocol MatchesDetailsViewModelInput {
    func goBack()
    func getTeams()
}

protocol MatchesDetailsViewModelOutput {
    var teams: Observable<[Teams]?> { get }
    var state: Observable<TeamsRepositoryState> { get }
    var finishLoading: Observable<Bool> { get }
    var match: Observable<Matches?> { get }
}

protocol MatchesDetailsViewModel: MatchesDetailsViewModelInput & MatchesDetailsViewModelOutput {}
