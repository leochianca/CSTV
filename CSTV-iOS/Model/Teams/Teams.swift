//
//  Teams.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

struct Teams: Codable {
    let id: Int
    let name: String
    let imageUrl: URL?
    let players: [Players]
}
