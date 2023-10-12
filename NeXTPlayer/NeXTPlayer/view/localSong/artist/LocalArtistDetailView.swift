//
//  LocalArtistListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 07/10/23.
//

import SwiftUI
import MediaPlayer

struct LocalArtistDetailView: View {
    @EnvironmentObject var localViewModel: LocalListViewModel
    let artist: LocalArtist
    
    init(artist: LocalArtist) {
        self.artist = artist
    }
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
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
                
                HStack(alignment: .center) {
                    Text(artist.name ?? "")
                        .font(.subheadline)
                        .foregroundColor(Color(.label))
                }
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)
                Spacer(minLength: 20)
            }
            .padding()
            LocalSongsForAlbumListView(songsViewModel: LocalSongsForAlbumListViewModel.example())
        }

    }

}

struct LocalArtistDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocalArtistDetailView(artist: LocalArtist.mockData().first!)
    }
}
