//
//  LocalArtistDetailRowView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 07/10/23.
//

import SwiftUI

struct LocalArtistRowView: View {
    @EnvironmentObject var viewModel: LocalListViewModel
    var artist: LocalArtist = LocalViewModelView.artistList
    var body: some View {
        HStack {
            Button {
                viewModel.setSelectedArtist(artist: artist)
            } label: {
                HStack {
                    
                    ArtWorkView(artWork: artist.artwork)
                    
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
        .frame(width: 300, alignment: .leading)
        .padding(.leading, 0)
    }
}

struct LocalArtistDetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        LocalArtistRowView()
            .environmentObject(LocalViewModelView.viewModel)
    }
}
