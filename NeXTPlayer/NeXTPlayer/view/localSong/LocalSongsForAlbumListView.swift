//
//  LocalSongsForAlbumListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 06/10/23.
//

import SwiftUI

struct LocalSongsForAlbumListView: View {
    @ObservedObject var songsViewModel: LocalSongsForAlbumListViewModel
    
    var body: some View {
        ScrollView {
            
            if songsViewModel.state == .isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                Grid(horizontalSpacing: 20){
                    ForEach(songsViewModel.songs) { song in
                        GridRow {
                            Text("\(song.trackNumber)")
                                .font(.footnote)
                                .gridColumnAlignment(.trailing)
                            
                            Text("\(song.trackName)")
                                .gridColumnAlignment(.leading)
                            
                            Spacer()
                            Text(Int().formattedDuration(time: song.trackTimeMillis))
                                .font(.footnote)
                            
                            .padding(.trailing)
                        }
                        Divider()
                    }
                }
                .padding([.vertical, .leading])
            }
        }
    }
}

struct LocalSongsForAlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        LocalSongsForAlbumListView(songsViewModel: LocalSongsForAlbumListViewModel.example())
    }
}
