//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 25/06/22.
//

import Foundation

enum GFError: String, Error {
    
    case invalidUsername =  "This username created an invalid request. try again"
    case unableToComplete = "Unable to complete your request. check your internet connection"
    case invalidResponse = "This request went bad. we sorry"
    case invalidData = "This request went bad. invalid data"
}
