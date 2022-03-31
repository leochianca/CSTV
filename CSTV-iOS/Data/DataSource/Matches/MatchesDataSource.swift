//
//  MatchesDataSource.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

protocol MatchesDataSource {
    func getAllMatches(page: Int, completion: @escaping (_ result: Result<[Matches], MatchesErrorMessage>) -> Void)
}
