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
            ForEach(viewModel.songs, id: \.trackID) { song in
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


struct ImageLoadingView: View {
    let urlString: String
    let size: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { image in
            image.resizable()
                .border(Color(white:0.8))
        } placeholder: {
            ProgressView()
        }
        .frame(width: size, height: size)
    }
}
                   
struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView(viewModel: SongsListViewModel.example())
    }
}
