//
//  SongListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 04/10/23.
//

import SwiftUI

struct SongListView: View {
    @ObservedObject var viewModel: SongsListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.songs) { song in
                SongRowView(song: song)
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



                   
struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView(viewModel: SongsListViewModel.example())
    }
}
