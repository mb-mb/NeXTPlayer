//
//  LocalAlbumSectionView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 09/10/23.
//

import SwiftUI

struct LocalAlbumSectionView: View {
    @ObservedObject var viewModel: LocalListViewModel
    let rows = Array(repeating: GridItem(.fixed(110), spacing:0, alignment: .leading), count: 2)

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 65) {
                ForEach(viewModel.albums, id:\.id) { album in
                    LocalAlbumRowView(album: album)
//                        .frame(width: 300, height: 70)
                }
//                .frame(width: 300, height: 120)
//                .background(Color.green)
                
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

struct LocalAlbumSectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocalAlbumSectionView(viewModel: LocalListViewModel().loadMock())
        }
    }
}
