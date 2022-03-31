//
//  MatchesViewModel.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

protocol MatchesViewModelInput {
    func getMatches()
    func refreshMatches()
    func goToDetails(match: Matches)
}

protocol MatchesViewModelOutput {
    var matches: Observable<[Matches]> { get }
    var finishLoading: Observable<Bool> { get }
}

protocol MatchesViewModel: MatchesViewModelInput & MatchesViewModelOutput {}
