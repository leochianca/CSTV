//
//  DateExtension.swift
//  CSTV-iOS
//
//  Created by Fuze on 01/04/22.
//

import Foundation

extension DateFormatter {
    private static func format(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = .autoupdatingCurrent
        formatter.locale = Locale(identifier: Locale.preferredLanguages[0])
        formatter.dateFormat = format

        return formatter
    }
    
    static func dateString(initialDate: Date, endDate: Date) -> String {
        let days = Calendar.daysDifference(initialDate: initialDate, endDate: endDate)
        switch days {
        case 0:
            let dateFormatter = self.format(format: "HH:mm")
            return "Hoje, \(dateFormatter.string(from: endDate))"
        case 1:
            let dateFormatter = self.format(format: "HH:mm")
            return "Amanhã, \(dateFormatter.string(from: endDate))"
        case 2, 3, 4, 5, 6:
            let dateFormatter = self.format(format: "E, HH:mm")
            let time = dateFormatter.string(from: endDate).replacingOccurrences(of: ".", with: "")
            return time.prefix(1).uppercased() + time.lowercased().dropFirst()
        default:
            let dateFormatter = self.format(format: "dd/MM HH:mm")
            return dateFormatter.string(from: endDate)
        }
    }
}

extension Calendar {
    static func daysDifference(initialDate: Date, endDate: Date) -> Int? {
        let matchDate = self.current.startOfDay(for: endDate)
        let currentDate = self.current.startOfDay(for: initialDate)
        
        return self.current.dateComponents([.day], from: currentDate, to: matchDate).day
    }
}
