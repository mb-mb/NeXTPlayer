//
//  MoviewRowView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 04/10/23.
//

import SwiftUI

struct MoviewRowView: View {
    let moview: Movie
    var body: some View {
        HStack {
            ImageLoadingView(urlString: moview.artworkUrl100, size: 90)
                .padding(.leading, 10)

            VStack(alignment: .leading) {
                Text(moview.trackName)
                Text(moview.primaryGenreName)
                    .foregroundColor(.gray)
                    .font(.caption)
                Text("Released: \(String.formattedDate(value: moview.releaseDate))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .lineLimit(1)
            Spacer(minLength: 20)
            BuyButton(urlString: moview.previewURL ?? "",
                      price: moview.trackPrice,
                      currency: moview.currency)
            .padding(.trailing, 5)
        }
        .frame(height: 75)
    }
}

struct MoviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        MoviewRowView(moview: Movie.example())
    }
}
