//
//  FontExtension.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation
import UIKit

enum RobotoType: String {
    case medium = "Medium"
    case bold = "Bold"
    case regular = "Regular"
}

extension UIFont {
    static func roboto(type: RobotoType, size: CGFloat) -> UIFont? {
        return UIFont(name: "Roboto-\(type)", size: size)
    }
}
