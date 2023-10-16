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
                    .progressViewStyle(.automatic)
            } else {
                Grid(horizontalSpacing: 20){
                    ForEach(songsViewModel.songs, id:\.id) { song in
                        GridRow {
                            HStack {
                                Button {
                                    songsViewModel.play(song: song)
                                } label: {
                                    Image(systemName: songsViewModel.songState(for: song))
                                        .font(.title)
                                        .frame(width: 38, height: 32)
                                        .background(Color.black.opacity(0.7))
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                        .foregroundColor(.orange)

                                }
                                .padding([.bottom, .top])
                                .foregroundColor(Color("buttonNavColor"))
                                .frame(width: 35, height: 19, alignment: .leading)
                                //                            .background(Color.gray)
                            }
                            HStack {
                                Text("\(song.trackNumber)")
                                    .font(.caption)
                                    .gridColumnAlignment(.trailing)
                                    .frame(width: 10, alignment: .leading)
                                Text("\(song.trackName)")
                                    .gridColumnAlignment(.leading)
                                    .font(.caption)
                                    .frame(width: 200, alignment: .leading)
                            }
                            .frame(width: 215, alignment: .leading)
//                            .background(Color.gray)
                            
                            if let timeLabel = songsViewModel.songTimeLabel(for: song) {
                                Text(timeLabel)
                                    .font(.caption)
                                    .frame(width: 45, alignment: .leading)
                                    .foregroundColor(.blue)
                                    .padding(.trailing)
                            } else {
                                Text(song.trackDuration)
                                    .font(.caption)
                                    .frame(width: 45, alignment: .leading)
                                    .padding(.trailing)
                            }
                            
                        }
                        Divider()
                    }
                }
                .onAppear {
                    AudioPlayerManager.shared.audioPlayer?.stop()
                }
                .padding([.vertical, .leading])
            }
        }
    }
}

struct LocalSongsForAlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        LocalSongsForAlbumListView(
            songsViewModel: LocalSongsForAlbumListViewModel.example())
    }
}

