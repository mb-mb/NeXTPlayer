//
//  NeXTPlayerApp.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 12/10/21.
//

import SwiftUI

@main
struct NeXTPlayerApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel(stateMachine: StateMachine(state: StateMachine.State.configuring)))                
        }
        
    }
    
}
