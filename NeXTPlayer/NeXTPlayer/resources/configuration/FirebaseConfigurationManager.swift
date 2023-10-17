//
//  FirebaseConfigurationManager.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 16/10/23.
//

import FirebaseRemoteConfig
import Firebase

// MARK: - FirebaseConfigurationManager
final class FirebaseConfigurationManager: ConfigurationManager {
    
    public static let shared = FirebaseConfigurationManager()
    
    private init() {}
    
    enum Exception: Error {
        case unknownFetchError
    }
    
    // MARK: - Remote config management
    func refresh() async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            remoteConfig.fetch { (status, error) in
                switch status {
                case .noFetchYet, .throttled, .success:
                    continuation.resume(returning: ())
                case .failure:
                    continuation.resume(throwing: error ?? Exception.unknownFetchError)
                @unknown default:
                    assertionFailure("Unsupported case when refreshing the Firebase remote configuration")
                }
            }
        }
    }
    
    // MARK: - Value processing
    func boolean(for configuration: ConfigurationToggle) -> Bool {
        remoteConfig[configuration.key].boolValue
    }
    
    func double(for configuration: ConfigurationToggle) -> Double {
        remoteConfig[configuration.key].numberValue.doubleValue
    }
    
    func integer(for configuration: ConfigurationToggle) -> Int {
        remoteConfig[configuration.key].numberValue.intValue
    }
    
    func string(for configuration: ConfigurationToggle) -> String? {
        remoteConfig[configuration.key].stringValue
    }
    
    func string(for configuration: ConfigurationToggle, defaultValue: String) -> String {
        string(for: configuration) ?? defaultValue
    }
    
    // MARK: - Dependencies
    private let remoteConfig: RemoteConfig = RemoteConfig.remoteConfig()
}
