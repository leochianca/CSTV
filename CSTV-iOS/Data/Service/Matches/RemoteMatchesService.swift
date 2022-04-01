//
//  RemoteMatchesService.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation
import Alamofire

class RemoteMatchesService: MatchesService {
    func getRunningMatches(completion: @escaping (Result<[MatchesResponse], MatchesErrorMessage>) -> Void) {
        AF.request(CsGoAPI.getRunningMatches).responseDecodable(of: [MatchesResponse].self) { response in
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(MatchesErrorMessage(message: error.localizedDescription)))
            }
        }
    }
    
    func getUpcomingMatches(page: Int, completion: @escaping (Result<[MatchesResponse], MatchesErrorMessage>) -> Void) {
        AF.request(CsGoAPI.getUpcomingMatches(page: page)).responseDecodable(of: [MatchesResponse].self) { response in
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(MatchesErrorMessage(message: error.localizedDescription)))
            }
        }
    }
}
