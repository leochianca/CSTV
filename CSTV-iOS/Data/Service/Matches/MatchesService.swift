//
//  MatchesService.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation
struct MatchesErrorMessage: Codable, Error {
    let message: String
}

protocol MatchesService {
    func getRunningMatches(completion: @escaping (_ result: Result<[MatchesResponse], MatchesErrorMessage>) -> Void)
    func getUpcomingMatches(page: Int, completion: @escaping (_ result: Result<[MatchesResponse], MatchesErrorMessage>) -> Void)
}
