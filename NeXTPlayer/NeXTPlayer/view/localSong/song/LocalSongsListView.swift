//
//  LocalSongsListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 09/10/23.
//

import SwiftUI

struct LocalSongsListView: View {
    @EnvironmentObject var viewModel: LocalListViewModel
    @ObservedObject var localSongsViewModel = LocalSongsForAlbumListViewModel(albumID: 0)
    
    var body: some View {
        List {
            ForEach(viewModel.songs, id: \.id) { song in
                LocalSongsRowView(viewModel: localSongsViewModel, song: song)
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

//struct LocalSongsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocalSongsListView(viewModel: LocalListViewModel().loadMock())
//    }
//}
