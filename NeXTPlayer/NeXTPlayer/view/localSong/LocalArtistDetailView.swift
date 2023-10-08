//
//  LocalArtistListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 07/10/23.
//

import SwiftUI

struct LocalArtistDetailView: View {
    @StateObject var localViewModel: LocalSongsForAlbumListViewModel
    let artist: LocalArtist
    
    init(artist: LocalArtist) {
        self.artist = artist
        self._localViewModel = StateObject(wrappedValue: LocalSongsForAlbumListViewModel(albumID: Int(artist.id)))
    }
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                ImageLoadingView(urlString: artist.artworkUrl100 ?? "", size: 100)
                VStack(alignment: .leading) {
                    Text("\(artist.id)")
                        .font(.footnote)
                        .foregroundColor(Color(.label))
                    Text(artist.name ?? "")
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

struct LocalArtistListView_Previews: PreviewProvider {
    static var previews: some View {
        LocalArtistDetailView(artist: LocalArtist(id: 1, name: "test", genre: "metal", artworkUrl100: ""))
    }
}
