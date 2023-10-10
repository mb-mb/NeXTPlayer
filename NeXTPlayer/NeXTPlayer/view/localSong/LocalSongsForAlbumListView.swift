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
                    ForEach(songsViewModel.songs, id:\.id) { song in
                        GridRow {
                            HStack {
                                Button {
                                    //songsViewModel.play(song: song)
                                } label: {
                                    Image(systemName: song.songState.rawValue)
                                        .frame(width: 15)
    //                                    .background(Color.gray)
                                        
                                }
                                .foregroundColor(.black)
                            }
                            .frame(width: 5, height: 15, alignment: .leading)
//                            .background(Color.gray)
                            HStack{
                                Text("\(song.trackNumber)")
                                    .font(.caption)
                                    .gridColumnAlignment(.trailing)
                                
                                Text("\(song.trackName)")
                                    .gridColumnAlignment(.leading)
                                    .font(.caption)
                            }
                            .frame(width: 250, alignment: .leading)
//                            .background(Color.gray)
                            Text(song.trackDuration)
                                .font(.caption)
                            
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
        LocalSongsForAlbumListView(
            songsViewModel: LocalSongsForAlbumListViewModel(
                albumID: LocalAlbum.mockData().first!.album.id))
    }
}
