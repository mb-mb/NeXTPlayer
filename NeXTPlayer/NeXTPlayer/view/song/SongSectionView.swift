//
//  SongSectionView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 05/10/23.
//

import SwiftUI

struct SongSectionView: View {
//    let songs: [Song]
    let rows = Array(repeating: GridItem(.fixed(65), spacing:0, alignment: .leading), count: 4)
    @ObservedObject var viewModel: SongsListViewModel
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 15) {
                
                ForEach(viewModel.songs, id:\.uuid) { song in
                    SongRowView(song: song)
                        .frame(width: 300)
                }
                
                switch viewModel.state {
                case .good:
                    Color.clear
                        .onAppear {
                            viewModel.loadMore()
                        }
                case .isLoading:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(maxWidth: .infinity)
                case .loadedAll:
                    EmptyView()
                case .error(let message):
                    Text(message)
                        .foregroundColor(.pink)
                }

            }
        }
        .padding([.horizontal, .bottom])
    }
}

struct SongSectionView_Previews: PreviewProvider {
    static var previews: some View {
        SongSectionView(viewModel: SongsListViewModel())
    }
}
