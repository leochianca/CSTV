//
//  RepositoryState.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

enum RepositoryState<ErrorType: Equatable>: Equatable {
    case idle
    case loading
    case loaded
    case error(_ error: ErrorType)
}
