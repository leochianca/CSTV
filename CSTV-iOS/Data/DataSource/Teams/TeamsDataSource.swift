//
//  TeamsDataSource.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

protocol TeamsDataSource {
    func getAllTeams(page: Int, completion: @escaping (_ result: Result<[Teams], TeamsErrorMessage>) -> Void)
}
