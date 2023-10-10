//
//  LocalAlbumDetailView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 06/10/23.
//

import SwiftUI

struct LocalAlbumDetailView: View {
    @StateObject var localViewModel: LocalSongsForAlbumListViewModel
    let album: LocalAlbum
    
    init( album: LocalAlbum) {
        self.album = album
        self._localViewModel = StateObject(wrappedValue:
                                            LocalSongsForAlbumListViewModel(albumID: album.album.id))
    }
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                ImageLoadingView(urlString: album.album.artworkUrl100, size: 100)
                VStack(alignment: .leading) {
                    Text(album.album.collectionName)
                        .font(.footnote)
                        .foregroundColor(Color(.label))
                    Text(album.album.artistName)
                        .padding(.bottom, 5)
                    
                    Text(album.album.primaryGenreName)
                    Text("\(album.album.trackCount) songs")
                              
                    Text("Released: \(String.formattedDate(value: album.album.releaseDate))")
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

struct LocalAlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocalAlbumDetailView(album: LocalAlbum.mockData().first!)
    }
}
