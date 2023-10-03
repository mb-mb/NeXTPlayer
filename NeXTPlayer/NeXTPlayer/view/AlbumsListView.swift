//
//  AlbumsListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 03/10/23.
//

import SwiftUI

struct AlbumsListView: View {
    @ObservedObject var viewModel: AlbumListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.albums) { album in
                Text(album.collectionName)
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
                //                    EmptyView()
                Color.gray
            case .error(let message):
                Text(message)
                    .foregroundColor(.red)
            }
            
        }
        .listStyle(.plain)
    }
  
}



struct AlbumsListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsListView(viewModel: AlbumListViewModel())
    }
}
