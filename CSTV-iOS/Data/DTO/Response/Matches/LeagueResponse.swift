//
//  LeagueResponse.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

struct LeagueResponse: Codable {
    let imageUrl: String?
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image_url"
    }
}

struct LeagueResponseMapper: DTOMapper {
    static func map(_ dto: LeagueResponse) -> League {
        var url: URL? = nil
        if let urlString = dto.imageUrl {
            url = URL(string: urlString)
        }
        
        return League(imageUrl: url, name: dto.name)
    }
}
