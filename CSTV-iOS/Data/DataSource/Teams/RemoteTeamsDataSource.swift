//
//  RemoteTeamsDataSource.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

class RemoteTeamsDataSource: TeamsDataSource {
    private let service: TeamsService
    
    init(service: TeamsService = RemoteTeamsService()) {
        self.service = service
    }
    
    func getAllTeams(page: Int, completion: @escaping (Result<[Teams], TeamsErrorMessage>) -> Void) {
        self.service.getAllTeams(page: page) { result in
            switch result {
            case .success(let teamsResponse):
                let teamsMapped = teamsResponse.map { TeamsResponseMapper.map($0) }
                completion(.success(teamsMapped))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
