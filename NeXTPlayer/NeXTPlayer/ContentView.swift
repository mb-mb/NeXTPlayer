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
            AlbumSearchView()
                .tabItem {
                    Label("Albums", image: "")
                }
            
            MovieSearchView()
                .tabItem {
                    Label("Movies", image: "")
                }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
