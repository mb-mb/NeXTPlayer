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
            ImageLoadingView(urlString: moview.artworkUrl60, size: 100)
            VStack(alignment: .leading) {
                Text(moview.collectionName ?? "")
                Text(moview.artistName)
            }
            .lineLimit(1)
            Spacer(minLength: 20)
            BuyButton(urlString: moview.collectionViewURL ?? "",
                      price: moview.collectionPrice,
                      currency: moview.currency)
        }
    }
}

struct MoviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        MoviewRowView(moview: Movie.mocl().first!)
    }
}
