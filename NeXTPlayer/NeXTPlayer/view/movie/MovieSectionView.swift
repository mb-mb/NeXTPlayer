//
//  MovieSectioView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 05/10/23.
//

import SwiftUI

struct MovieSectionView: View {
    let movies: [Movie]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top, spacing: 10) {
                ForEach(movies) { movie in
                    VStack(alignment: .leading) {
                        ImageLoadingView(urlString: movie.artworkUrl100, size: 90)
//                            .padding(.leading, 10)
                        Text(movie.trackName)
                        Text(movie.primaryGenreName)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 10)
                    .lineLimit(2)
                    .frame(width: 80)
                    .font(.caption)
                }
            }
        }
        .padding([.horizontal, .bottom])
    }
}

struct MovieSectionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSectionView(movies: Movie.examples())
    }
}
