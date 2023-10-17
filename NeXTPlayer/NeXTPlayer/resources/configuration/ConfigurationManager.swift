//
//  ConfigurationManager.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 16/10/23.
//

import Foundation

// MARK: - ConfigurationManager
protocol ConfigurationManager: ConfigurationProvider {
    func refresh() async throws
}
