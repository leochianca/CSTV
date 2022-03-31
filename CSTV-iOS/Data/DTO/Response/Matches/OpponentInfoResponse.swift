//
//  OpponentInfoResponse.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

struct OpponentInfoResponse: Codable {
    let imageUrl: String?
    let name: String
    let id: Int
    
    private enum CodingKeys: String, CodingKey {
        case name, id
        case imageUrl = "image_url"
    }
}

struct OpponentInfoResponseMapper: DTOMapper {
    static func map(_ dto: OpponentInfoResponse) -> OpponentInfo {
        var url: URL? = nil
        if let urlString = dto.imageUrl {
            url = URL(string: urlString)
        }
        
        return OpponentInfo(imageUrl: url, name: dto.name, id: dto.id)
    }
}
