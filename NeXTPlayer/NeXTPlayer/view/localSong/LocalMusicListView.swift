//
//  LocalMusicListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 04/10/23.
//

import SwiftUI
import MediaPlayer
import MusicKit

struct LocalMusicListView: View {
    @ObservedObject var viewModel:  SongsListViewModel

    var body: some View {
        NavigationView {
            Group {
                VStack {
                    Text("Music Player")
                        .font(.title)
                    
                    Button(action: {
                        // Play the playback queue.
                        Task {
                            try await viewModel.playSong()
                        }
                        
                    }) {
                        Text("Play")
                    }
                    
                    Button(action: {
                        // Pause the playback queue.
                        ApplicationMusicPlayer.shared.pause()
                    }) {
                        Text("Pause")
                    }
                    
                    Button(action: {
                        // Stop the playback queue.
                        ApplicationMusicPlayer.shared.stop()
                    }) {
                        Text("Stop")
                    }
                }
                
                List {
                    ForEach (viewModel.getSongs(), id:\.albumArtistPersistentID) { song in
                        Text(song.artist ?? "no name")
                    }
                }
            }
        }
    }
    
}

struct LocalMusicListView_Previews: PreviewProvider {
    static var previews: some View {
        LocalMusicListView(viewModel: SongsListViewModel())
    }
}
