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
                    ForEach(songsViewModel.songs, id:\.id) { song in
                        GridRow {
                            Text("\(song.trackNumber)")
                                .gridColumnAlignment(.trailing)
                                .frame(width: 15, alignment: .leading)
                            Text("\(song.trackName)")
//                                .gridColumnAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            Text(Int().formattedDuration(time: song.trackTimeMillis))
                                .frame(width: 35, alignment: .trailing)
                            
                            BuySongButton(urlString: song.previewURL,
                                          price: song.trackPrice,
                                          currency: song.currency)
                            .frame(width: 70, alignment: .leading)
                            .padding(.trailing, 5)
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
