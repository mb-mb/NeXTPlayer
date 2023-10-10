//
//  LocalArtistListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 07/10/23.
//

import SwiftUI
import MediaPlayer

struct LocalArtistDetailView: View {
    @StateObject var localViewModel: LocalListViewModel
    let artist: LocalArtist
    
    init(artist: LocalArtist) {
        self.artist = artist
        self._localViewModel = StateObject(wrappedValue: LocalListViewModel())
    }
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                ImageLoadingView(urlString: artist.artworkUrl100?.absoluteString ?? "", size: 100)
                HStack(alignment: .center) {
                    Text(artist.name ?? "")
                        .font(.subheadline)
                        .foregroundColor(Color(.label))
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

struct LocalArtistDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocalArtistDetailView(artist: LocalArtist.mockData().first!)
    }
}
