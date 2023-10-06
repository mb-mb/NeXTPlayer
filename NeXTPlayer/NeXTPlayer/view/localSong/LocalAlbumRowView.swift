//
//  LocalALbumRowView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 06/10/23.
//

import SwiftUI

struct LocalAlbumRowView: View {
    
    let album: Album
    var body: some View {
        HStack {
            ImageLoadingView(urlString: album.artworkUrl60, size: 100)
            VStack(alignment: .leading) {
                Text(album.collectionName)
                Text(album.artistName)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .lineLimit(1)
            Spacer(minLength: 20)
        }
    }
}

struct LocalALbumRowView_Previews: PreviewProvider {
    static var previews: some View {
        LocalAlbumRowView(album: Album.example())
    }
}
