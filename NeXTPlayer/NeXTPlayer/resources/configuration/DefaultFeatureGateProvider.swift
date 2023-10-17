//
//  DefaultFeatureGateProvider.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 16/10/23.
//

import Foundation

// MARK: - FeatureGateProvider
protocol FeatureGateProvider {
    func isGateOpen(_ featureGate: FeatureGate) -> Bool
}

// MARK: - DefaultFeatureGateProvider
final class DefaultFeatureGateProvider: FeatureGateProvider {
    // MARK: - Initializers
    init(configurationProvider: ConfigurationProvider) {
        self.configurationProvider = configurationProvider
    }
    
    // MARK: - Gate management
    func isGateOpen(_ featureGate: FeatureGate) -> Bool {
        configurationProvider.boolean(for: .custom(key: featureGate.key))
    }
    
    // MARK: - Dependencies
    private let configurationProvider: ConfigurationProvider
}
