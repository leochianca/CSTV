//
//  MatchesResponse.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

struct MatchesResponse: Codable {
    let league: LeagueResponse
    let opponents: [OpponentResponse]
    let status: String
    let date: String?
    
    private enum CodingKeys: String, CodingKey {
        case league, opponents, status
        case date = "begin_at"
    }
}

struct MatchesResponseMapper: DTOMapper {
    static func map(_ dto: MatchesResponse) -> Matches {
        var opponents: [Opponent] = []
        for opponent in dto.opponents {
            opponents.append(OpponentResponseMapper.map(opponent))
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-ddd'T'HH:mm:ssZ"
        let date = formatter.date(from: dto.date ?? "")
        
        return Matches(league: LeagueResponseMapper.map(dto.league), opponents: opponents, status: dto.status, date: date)
    }
}
