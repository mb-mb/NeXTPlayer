//
//  AuthManager.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 30/09/23.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var expirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshTOken: Bool {
        return false
    }
    
}
