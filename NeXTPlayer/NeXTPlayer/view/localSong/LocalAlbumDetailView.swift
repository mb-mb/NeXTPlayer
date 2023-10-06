//
//  LocalAlbumDetailView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 06/10/23.
//

import SwiftUI

struct LocalAlbumDetailView: View {
    @StateObject var localViewModel: LocalSongsForAlbumListViewModel
    let album: Album
    
    init( album: Album) {
        self.album = album
        self._localViewModel = StateObject(wrappedValue: LocalSongsForAlbumListViewModel(albumID: album.id))
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
            }
            .padding()
            LocalSongsForAlbumListView(songsViewModel: localViewModel)
        }
        .onAppear {
            localViewModel.fetch()
        }
    }
}

struct LocalAlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocalAlbumDetailView(album: Album.example())
    }
}
