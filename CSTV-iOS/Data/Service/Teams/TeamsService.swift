//
//  TeamsService.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

struct TeamsErrorMessage: Codable, Error {
    let message: String
}

protocol TeamsService {
    func getAllTeams(page: Int, completion: @escaping (_ result: Result<[TeamsResponse], TeamsErrorMessage>) -> Void)
}
