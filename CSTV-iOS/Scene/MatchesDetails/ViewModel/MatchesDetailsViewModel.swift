//
//  MatchesDetailsViewModel.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

protocol MatchesDetailsViewModelInput {
    func goBack()
}

protocol MatchesDetailsViewModelOutput {}

protocol MatchesDetailsViewModel: MatchesDetailsViewModelInput & MatchesDetailsViewModelOutput {}
