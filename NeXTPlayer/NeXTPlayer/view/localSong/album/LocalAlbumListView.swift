//
//  LocalAlbumListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 09/10/23.
//

import SwiftUI

struct LocalAlbumListView: View {
    @ObservedObject var viewModel: LocalListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.artists, id: \.id) { artist in
                LocalArtistRowView(artist: artist)
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
        .listStyle(.plain)
    }
}

struct LocalAlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        LocalAlbumListView(viewModel: LocalListViewModel().loadMock())
    }
}
