//
//  TeamsResponse.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

struct TeamsResponse: Codable {
    let id: Int
    let name: String
    let imageUrl: String?
    let players: [PlayersResponse]
    
    private enum CodingKeys: String, CodingKey {
        case id, name, players
        case imageUrl = "image_url"
    }
}

struct TeamsResponseMapper: DTOMapper {
    static func map(_ dto: TeamsResponse) -> Teams {
        var url: URL? = nil
        if let urlString = dto.imageUrl {
            url = URL(string: urlString)
        }
        
        var players: [Players] = []
        for player in dto.players {
            players.append(PlayersResponseMapper.map(player))
        }
        
        return Teams(id: dto.id, name: dto.name, imageUrl: url, players: players)
    }
}
