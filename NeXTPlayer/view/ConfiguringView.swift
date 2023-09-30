//
//  Configuring.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 19/10/21.
//

import SwiftUI

struct ConfiguringView: View {
    @ObservedObject var viewModel: ContentViewModel

    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
        viewModel.fetchArtists()
        viewModel.state = .start
    }
    var body: some View {
        Text("running setup")
    }
}

struct Configuring_Previews: PreviewProvider {
    static var previews: some View {
        ConfiguringView(viewModel: ContentViewModel(stateMachine: StateMachine(state: .configuring)))
    }
}
