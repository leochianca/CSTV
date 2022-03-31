//
//  PlayersResponse.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

struct PlayersResponse: Codable {
    let firstName: String?
    let lastName: String?
    let nickname: String
    let imageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case nickname = "name"
        case imageUrl = "image_url"
    }
}

struct PlayersResponseMapper: DTOMapper {
    static func map(_ dto: PlayersResponse) -> Players {
        var url: URL? = nil
        if let urlString = dto.imageUrl {
            url = URL(string: urlString)
        }
        return Players(firstName: dto.firstName, lastName: dto.lastName, nickname: dto.nickname, imageUrl: url)
    }
}
