//
//  CsGoAPI.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation
import Alamofire

enum CsGoAPI {
    case getAllMatches(page: Int)
    case getAllTeams(page: Int)
}

extension CsGoAPI {
    var baseURL: String {
        return "https://api.pandascore.co"
    }

    var method: HTTPMethod {
        switch self {
        case .getAllMatches, .getAllTeams:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getAllMatches:
            return "/csgo/matches"
        case .getAllTeams:
            return "/csgo/teams"
        }
    }
    
    var parameters: String {
        switch self {
        case .getAllMatches(let page), .getAllTeams(let page):
            return String(page)
        }
    }
}

extension CsGoAPI: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let urlString = "\(baseURL)\(path)"
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [URLQueryItem(name: "page", value: parameters)]
        
        var urlRequest = URLRequest(url: urlComponents!.url!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        urlRequest.setValue("Bearer RsIcE8L8pkF12Zl_W6kymOmu2Ye4Q_ToqiXtOVIic7dxqr6jRJ0", forHTTPHeaderField: "Authorization")

        return urlRequest
    }
}
