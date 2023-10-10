//
//  LocalSongsDetailView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 07/10/23.
//

import SwiftUI

struct LocalSongsDetailView: View {
    @StateObject var localViewModel: LocalSongsForAlbumListViewModel
    let song: LocalSong
    
    init(song: LocalSong) {
        self.song = song
        self._localViewModel = StateObject(wrappedValue: LocalSongsForAlbumListViewModel(albumID: LocalAlbum.mockData().first?.album.id ?? 0))
    }
    var body: some View {
        
        VStack {
            
            //ImageLoadingView(urlString: song.song.artworkUrl60, size: 100)
            
            Text("\(song.trackName)")
                .gridColumnAlignment(.leading)
                .font(.title)

            Button {
                localViewModel.play(song: song)
            } label: {
                Image(systemName: localViewModel.songState)
                    .font(.largeTitle)
            }
            .foregroundColor(.black)
            .padding()
            HStack {
                Text(song.trackDuration)
                    .font(.caption)
                Text("|")
                Text(localViewModel.timeLabel)
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            .font(.caption)
        }
        
    }

}

struct LocalSongsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocalSongsDetailView(song: LocalSong.mock().first!)
    }
}
