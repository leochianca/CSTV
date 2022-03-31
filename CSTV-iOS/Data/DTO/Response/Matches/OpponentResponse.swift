//
//  OpponentResponse.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

struct OpponentResponse: Codable {
    let opponent: OpponentInfoResponse
}

struct OpponentResponseMapper: DTOMapper {
    static func map(_ dto: OpponentResponse) -> Opponent {
        return Opponent(opponent: OpponentInfoResponseMapper.map(dto.opponent))
    }
}
