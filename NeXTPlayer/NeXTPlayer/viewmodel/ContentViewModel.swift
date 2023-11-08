//
//  ContentViewModel.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 16/10/23.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var isLoading: Bool = false

    func fetchRemoteConfig() {
        isLoading = true
        RemoteConfigManager.shared.fetchRemoteConfig { result in
            DispatchQueue.main.async {[weak self] in
                self?.isLoading = false
                switch result {
                case .success:
                    let isBannerEnabled = RemoteConfigManager.shared.getBoolParameter(forKey: .enableBannerV1)
                    UserDefaults.standard.setValue(isBannerEnabled, forKey: "isBannerEnabled")
                case .failure(let error):
                    print("Error fetching remote config: \(error.localizedDescription)")
                    UserDefaults.standard.setValue(false, forKey: "isBannerEnabled")
                }
            }
        }
    }
}
