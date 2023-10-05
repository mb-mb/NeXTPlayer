//
//  SongSectionView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 05/10/23.
//

import SwiftUI

struct SongSectionView: View {
    let songs: [Song]
    let rows = Array(repeating: GridItem(.fixed(60), spacing:0, alignment: .leading), count: 4)
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 15) {
                
                ForEach(songs, id:\.id) { song in
                    SongRowView(song: song)
                        .frame(width: 300)
                }
            }
        }
        .padding([.horizontal, .bottom])
    }
}

struct SongSectionView_Previews: PreviewProvider {
    static var previews: some View {
        SongSectionView(songs: SongsListViewModel.example().songs)
    }
}
