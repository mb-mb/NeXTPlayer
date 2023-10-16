//
//  ContentView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 03/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Group {
            VStack{
                
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
                // #1

                HStack(alignment: .bottom) {
                    Spacer()
                    SwiftUIBannerAd(adPosition: .bottom,
                                    adUnitId: SwiftUIMobileAds.testBannerId)
//                    .padding(.bottom, 0)
                }
                //        .background(.green)
                .frame(height: 50)

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
