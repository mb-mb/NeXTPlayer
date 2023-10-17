//
//  Configuration.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 16/10/23.
//

// Configuration.swift

import Foundation

// MARK: - Configuration
enum ConfigurationToggle {
    case custom(key: String)
    /* insert future configuration keys here */
    
    var key: String {
        switch self {
        case let .custom(customKey):
            return customKey
        }
    }
}
