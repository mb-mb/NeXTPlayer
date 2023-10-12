//
//  LocalArtistDetailRowView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 07/10/23.
//

import SwiftUI

struct LocalArtistRowView: View {
    @EnvironmentObject var viewModel: LocalListViewModel
    let artist: LocalArtist
    var body: some View {
        HStack {
            Button {
                viewModel.setSelectedArtist(artist: artist)
            } label: {
                HStack {
                    if let data = artist.artwork,
                       let image = UIImage(data: data) {
                        Image(uiImage: image )
                            .resizable()
                            .frame(width:100, height: 100)
                            .cornerRadius(8)

                    } else {
                        Image(systemName: "music.note.house")
                            .frame(width:100, height: 100)
                    }
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
        LocalArtistRowView(artist: LocalArtist.mockData().first!)
            .environmentObject(LocalViewModelView.viewModel)
    }
}
