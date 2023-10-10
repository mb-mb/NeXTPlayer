//
//  EntityType.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 04/10/23.
//

import Foundation

enum EntityType: String, Identifiable, CaseIterable {
    case all
    case album
    case song
    case movie
    
    var id: String {
        self.rawValue
    }
    
    func name() -> String {
        switch self {
            
        case .all:
            return "All"
        case .album:
            return "Albuns"
        case .song:
            return "Songs"
        case .movie:
            return "Movies"
        }
    }
}
