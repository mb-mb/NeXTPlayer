//
//  FeatureGate.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 16/10/23.
//

import Foundation


// MARK: - FeatureGate
enum FeatureGate: String {
    case enableBannerV1 = "enable_banner_v1"
    
    var key: String { rawValue }
}
