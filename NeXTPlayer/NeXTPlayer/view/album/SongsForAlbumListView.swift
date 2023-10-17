//
//  SongsForAlbumListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 05/10/23.
//

import SwiftUI

struct SongsForAlbumListView: View {
    @ObservedObject var songsViewModel: SongsForAlbumListViewModel
    
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
                                .gridColumnAlignment(.trailing)
                            
                            Text("\(song.trackName)")
                                .gridColumnAlignment(.leading)
                            
                            Spacer()
                            Text(Int().formattedDuration(time: song.trackTimeMillis))
                            
                            BuySongButton(urlString: song.previewURL,
                                          price: song.trackPrice,
                                          currency: song.currency)
                            .padding(.trailing)
                        }
                        .font(.caption)
                        Divider()
                    }
                }
                .padding([.vertical, .leading])
            }
        }
    }
    

}

struct SongsForAlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        SongsForAlbumListView(songsViewModel: SongsForAlbumListViewModel.example())
    }
}
