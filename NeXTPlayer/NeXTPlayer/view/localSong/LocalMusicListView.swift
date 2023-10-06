//
//  LocalMusicListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 04/10/23.
//

import SwiftUI
import MediaPlayer
import MusicKit

struct LocalMusicListView: View {
    @ObservedObject var viewModel: LocalListViewModel
    
    var body: some View {
        
        List {
            ForEach(viewModel.albums) { album in
//                NavigationLink {
//                    AlbumDetailView(album: album)
//                } label: {
//                    AlbumRowView(album: album)
//                }
                Text("\(album.id)")
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
                    .foregroundColor(.red)
            }
            
        }
        .listStyle(.plain)
    }
    
}

struct LocalMusicListView_Previews: PreviewProvider {
    static var previews: some View {
        LocalMusicListView(viewModel: LocalListViewModel())
    }
}
