//
//  Date.Ext.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 15/08/22.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
