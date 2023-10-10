//
//  LocalArtistDetailRowView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 07/10/23.
//

import SwiftUI

struct LocalArtistRowView: View {
    let artist: LocalArtist
    var body: some View {
        HStack {
            ImageLoadingView(urlString: artist.artworkUrl100?.absoluteString ?? "", size: 100)
            VStack(alignment: .leading) {
//                Text("\(artist.id)")
                Text(artist.name ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .lineLimit(1)
            Spacer(minLength: 20)
        }
    }
}

struct LocalArtistDetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        LocalArtistRowView(artist: LocalArtist.mockData().first!)
    }
}
