//
//  AlbumSearchView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 03/10/23.
//

import SwiftUI

struct AlbumSearchView: View {
    @StateObject var viewModel = AlbumListViewModel()
    var body: some View {
        NavigationView {
            Group {
                if viewModel.searchTerm.isEmpty {
                    SearchPlaceholderView(searchTerm: $viewModel.searchTerm)
                } else {
                    AlbumsListView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Albums")
        }
    }
        
}



struct AlbumSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSearchView()
    }
}
