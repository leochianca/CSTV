//
//  Matches.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

struct Matches: Codable {
    let league: League
    let opponents: [Opponent]
    let status: String
    let date: Date?
}
