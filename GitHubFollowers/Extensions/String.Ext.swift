//
//  File.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 15/08/22.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale     = Locale(identifier: "pt_BR")
        dateFormatter.timeZone   = .current
        
        return dateFormatter.date(from: self)
    }
    
    func converToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
