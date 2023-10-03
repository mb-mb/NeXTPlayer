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
    
    
    public var signInURL: URL? = {
        let scopes = "user-read-pivate"
        let baseURL = "https://accounts.spotify.com/authorize"
//        let redURL = "nextplayerpro://"
//        let redirectURL = "spotify-ios-quick-start://spotify-login-callback"
        let string = "\(baseURL)?response_type=code&client_id=\(spotifyClientId)&redirect_uri=\(redirectURL)&show_dialog=TRUE"
        return URL(string: string)
    }()
    
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
    
    public func exchangeCodeForToken(
        code: String,
        completion: @escaping ((Bool) -> Void)
    ) {
        // get token
        guard let url = URL(string: tokenAPIURL) else { return }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "authorization_code"),
            URLQueryItem(name: "code",
                         value: "code"),
            URLQueryItem(name: "redirect_uri",
                         value: "\(redirectURL)")
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = spotifyClientId+":"+spotifyClientSecretKey
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("failure to get base64")
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String) ", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data,
                                                        options: .allowFragments)
                print("SUCCESS: \(json)")
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    public func refreshAccessToken() {
        
    }
    
    public func cachedToken() {
        
    }
}

