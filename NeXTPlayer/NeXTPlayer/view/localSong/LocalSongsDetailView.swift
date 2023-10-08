//
//  LocalSongsDetailView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 07/10/23.
//

import SwiftUI

struct LocalSongsDetailView: View {
    @StateObject var localViewModel: LocalSongsForAlbumListViewModel
    let song: LocalSong2
    
    init(song: LocalSong2) {
        self.song = song
        self._localViewModel = StateObject(wrappedValue: LocalSongsForAlbumListViewModel())
    }
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                ImageLoadingView(urlString: song.artworkUrl100 ?? "", size: 100)
                VStack(alignment: .leading) {
                    Text("\(song.id)")
                        .font(.footnote)
                        .foregroundColor(Color(.label))
                    Text(song.name ?? "")
                        .padding(.bottom, 5)
                    
                }
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)
                Spacer(minLength: 20)
            }
            .padding()
            LocalSongsForAlbumListView(songsViewModel: LocalSongsForAlbumListViewModel.example())
        }
        .onAppear {
//            localViewModel.fetch()
        }
    }

}

struct LocalSongsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocalSongsDetailView(song: LocalSong2(id: 1, name: "local songs 2", genre: "metal", title: "the local song"))
    }
}
