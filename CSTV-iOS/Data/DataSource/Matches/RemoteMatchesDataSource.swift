//
//  RemoteMatchesDataSource.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

class RemoteMatchesDataSource: MatchesDataSource {
    private let service: MatchesService
    
    init(service: MatchesService = RemoteMatchesService()) {
        self.service = service
    }
    
    func getRunningMatches(completion: @escaping (Result<[Matches], MatchesErrorMessage>) -> Void) {
        self.service.getRunningMatches { result in
            switch result {
            case .success(let matchesResponse):
                let matchesMapped = matchesResponse.map { MatchesResponseMapper.map($0) }
                completion(.success(matchesMapped))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUpcomingMatches(page: Int, completion: @escaping (Result<[Matches], MatchesErrorMessage>) -> Void) {
        self.service.getUpcomingMatches(page: page) { result in
            switch result {
            case .success(let matchesResponse):
                let matchesMapped = matchesResponse.map { MatchesResponseMapper.map($0) }
                completion(.success(matchesMapped))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
