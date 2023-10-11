//
//  LocalArtistSectionView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 09/10/23.
//

import SwiftUI

struct LocalArtistSectionView: View {
    @ObservedObject var viewModel: LocalListViewModel
    let rows = Array(repeating: GridItem(.fixed(110), spacing:0, alignment: .leading), count: 1)
        
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 55) {
                ForEach(viewModel.artists, id:\.id) { artist in
                    LocalArtistRowView(viewModel: viewModel, artist: artist)
                        .frame(width: 300, height: 50)
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

struct LocalArtistSectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocalArtistSectionView(viewModel: LocalListViewModel().loadMock())
        }
    }
}
