//
//  ConfigurationProvider.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 16/10/23.
//


// MARK: - ConfigurationProvider
protocol ConfigurationProvider {
    func boolean(for configuration: ConfigurationToggle) -> Bool
    func double(for configuration: ConfigurationToggle) -> Double
    func integer(for configuration: ConfigurationToggle) -> Int
    func string(for configuration: ConfigurationToggle) -> String?
    func string(for configuration: ConfigurationToggle, defaultValue: String) -> String
}
