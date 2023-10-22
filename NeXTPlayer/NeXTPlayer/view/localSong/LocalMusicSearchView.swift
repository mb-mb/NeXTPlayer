//
//  LocalMusicSearchView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 04/10/23.
//

import SwiftUI

struct LocalMusicSearchView: View {
    @StateObject var localViewModel = LocalListViewModel()
    var body: some View {
        NavigationView {
            Group {
                LocalSearchAllListView()
                    .environmentObject(localViewModel)
            }

        }
    }
}

struct LocalMusicSPlaceholderView: View {
    @Binding var searchTerm: String
     
    let suggestions = ["tool", "animals as leader", "polyphia"]
    
    var body: some View {
        VStack {
            Text("Trending")
                .font(.title)
            ForEach(suggestions, id: \.self) { text in
                Button {
                    searchTerm = text
                } label: {
                    Text(text)
                }

            }
        }
    }
}

struct LocalMusicSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocalMusicSearchView()
    }
}
