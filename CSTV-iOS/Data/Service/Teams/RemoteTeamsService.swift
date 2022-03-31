//
//  RemoteTeamsService.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation
import Alamofire

class RemoteTeamsService: TeamsService {
    func getAllTeams(page: Int, completion: @escaping (Result<[TeamsResponse], TeamsErrorMessage>) -> Void) {
        AF.request(CsGoAPI.getAllTeams(page: page)).responseDecodable(of: [TeamsResponse].self) { response in
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(TeamsErrorMessage(message: error.localizedDescription)))
            }
        }
    }
}
