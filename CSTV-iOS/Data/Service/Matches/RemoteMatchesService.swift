//
//  RemoteMatchesService.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation
import Alamofire

class RemoteMatchesService: MatchesService {
    func getAllMessages(page: Int, completion: @escaping (Result<[MatchesResponse], MatchesErrorMessage>) -> Void) {
        AF.request(CsGoAPI.getAllMatches(page: page)).responseDecodable(of: [MatchesResponse].self) { response in
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(MatchesErrorMessage(message: error.localizedDescription)))
            }
        }
    }
}
