//
//  ContentView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 03/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            AlbumSearchView()
                .tabItem {
                    Label("Albums", systemImage: "music.note")
                }
            
            MovieSearchView()
                .tabItem {
                    Label("Movies", systemImage: "tv")
                }

            LocalMusicSearchView()
                .tabItem {
                    Label("Local media", systemImage: "tv")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
