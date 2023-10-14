//
//  LocalArtistListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 07/10/23.
//

import SwiftUI
import MediaPlayer

struct LocalArtistDetailView: View {
//    @EnvironmentObject var localViewModel: LocalListViewModel
//    let artist: LocalArtist
//    
//    init(artist: LocalArtist) {
////        self.artist = artist
//    }
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                
                //                ArtWorkView(artWork: artist.artwork)
                //
                //                HStack(alignment: .center) {
                //                    Text(artist.name ?? "")
                //                        .font(.subheadline)
                //                        .foregroundColor(Color(.label))
                //                }
                //                .font(.caption)
                //                .foregroundColor(.gray)
                //                .lineLimit(1)
                //                Spacer(minLength: 20)
                //            }
                //            .padding()
                //            LocalSongsForAlbumListView(songsViewModel: LocalSongsForAlbumListViewModel(albumID: UInt64(0)))
            }
            
        }

    }

}

struct LocalArtistDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocalArtistDetailView() //artist: LocalArtist.mockData().first!
    }
}
