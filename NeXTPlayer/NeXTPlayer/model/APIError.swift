//
//  APIError.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 03/10/23.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    var description: String {
        switch self {
            
        case .badURL:
            return "badURL"
        case .urlSession(let error):
            return "urlSession error \(error.debugDescription)"
        case .badResponse(let error):
            return "bad response \(error.description)"
        case .decoding(let error):
            return "decoding error \(String(describing: error.errorDescription))"
        case .unknow:
            return "unknow error"
        }
    }
    
    case badURL
    case urlSession(URLError?)
    case badResponse(Int)
    case decoding(DecodingError)
    case unknow
}
