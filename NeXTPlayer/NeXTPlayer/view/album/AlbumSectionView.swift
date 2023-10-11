//
//  AlbumSectionView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 05/10/23.
//

import SwiftUI

struct AlbumSectionView: View {
    var albums: [Album]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top) {
                ForEach(albums) { album in
                    VStack(alignment: .leading) {
                        ImageLoadingView(urlString: album.artworkUrl100, size: 100)
                        Text(album.collectionName)
                        Text(album.artistName)
                            .foregroundColor(.gray)
                    }
                    .lineLimit(2)
                    .frame(width: 100)
                    .font(.caption)
                }
            }
        }
        .padding([.horizontal, .bottom])
    }
}

struct AlbumSectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AlbumSectionView(albums: [Album.example()])
        }
    }
}
