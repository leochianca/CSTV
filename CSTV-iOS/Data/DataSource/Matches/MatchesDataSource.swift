//
//  MatchesDataSource.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

protocol MatchesDataSource {
    func getRunningMatches(completion: @escaping (_ result: Result<[Matches], MatchesErrorMessage>) -> Void)
    func getUpcomingMatches(page: Int, completion: @escaping (_ result: Result<[Matches], MatchesErrorMessage>) -> Void)
}
