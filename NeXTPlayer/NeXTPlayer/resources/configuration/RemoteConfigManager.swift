//
//  RemoteConfigManager.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 16/10/23.
//

import FirebaseRemoteConfig

class RemoteConfigManager {
    static let shared = RemoteConfigManager()
    
    private let remoteConfig: RemoteConfig
    
    private init() {
        remoteConfig = RemoteConfig.remoteConfig()
    }
    
    func fetchRemoteConfig(completion: @escaping (Result<Void, Error>) -> Void) {
        let fetchDuration: TimeInterval = 300 // Cache 

        remoteConfig.fetch(withExpirationDuration: fetchDuration) { status, error in
            if status == .success {
                self.remoteConfig.activate { _, _ in
                    completion(.success(()))
                }
            } else {
                completion(.failure(error ?? RemoteConfigError.unknownError))
            }
        }
    }
    
    func getStringParameter(forKey key: String) -> String {
        return remoteConfig.configValue(forKey: key).stringValue ?? ""
    }
    func getBoolParameter(forKey key: FeatureGate) -> Bool {
        return remoteConfig.configValue(forKey: key.rawValue).boolValue
    }

    
}

enum RemoteConfigError: Error {
    case unknownError
}


