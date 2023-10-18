//
//  AlbumRowView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 04/10/23.
//

import SwiftUI

struct AlbumRowView: View {
    
    let album: Album
    var body: some View {
        HStack {
            ImageLoadingView(urlString: album.artworkUrl60, size: 90)
                .cornerRadius(1)
                //.padding([.leading, .top, .bottom])
            
            VStack(alignment: .leading) {
                Text(album.collectionName)
                Text(album.artistName)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .lineLimit(1)
            Spacer(minLength: 20)
            BuyButton(urlString: album.collectionViewURL,
                      price: album.collectionPrice,
                      currency: album.currency)
            .padding(.trailing, 5)
        }
        .frame(height: 75)
    }
}

struct AlbumRowView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumRowView(album: Album.example() )
    }
}
