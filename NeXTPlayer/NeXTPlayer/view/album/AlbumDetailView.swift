//
//  AlbumDetailView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 05/10/23.
//

import SwiftUI

struct AlbumDetailView: View {
    @StateObject var songsViewModel: SongsForAlbumListViewModel
    let album: Album
    
    init( album: Album) {
        self.album = album
        self._songsViewModel = StateObject(wrappedValue: SongsForAlbumListViewModel(albumID: album.id))
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                ImageLoadingView(urlString: album.artworkUrl100, size: 100)
                VStack(alignment: .leading) {
                    Text(album.collectionName)
                        .font(.footnote)
                        .foregroundColor(Color(.label))
                    Text(album.artistName)
                        .padding(.bottom, 5)
                    
                    Text(album.primaryGenreName)
                    Text("\(album.trackCount) songs")
                              
                    Text("Released: \(String.formattedDate(value: album.releaseDate))")
                }
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)
                Spacer(minLength: 20)
                BuyButton(urlString: album.collectionViewURL,
                          price: album.collectionPrice,
                          currency: album.currency)
            }
            .padding()
            SongsForAlbumListView(songsViewModel: songsViewModel)
        }
        .onAppear {
            songsViewModel.fetch()
        }
    }
    

}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(album: Album.example())
    }
}
