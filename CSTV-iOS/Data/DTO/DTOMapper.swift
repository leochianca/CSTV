//
//  DTOMapper.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

protocol DTOMapper {
    associatedtype DataModel
    associatedtype DomainModel
    
    static func map(_ dto: DataModel) -> DomainModel
}
