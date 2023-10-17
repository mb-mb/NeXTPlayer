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
    @EnvironmentObject var viewModel: LocalListViewModel
    
    var body: some View {
            LazyVStack {
                NavigationView {

                Section(header: Text("Artists")) {
                    ForEach(viewModel.artists) { artists in
                        NavigationLink {
                            LocalArtistDetailView()
                        } label: {
                            LocalArtistRowView(artist: artists)
                                .environmentObject(viewModel)
                        }
                    }
                } 
                Section(header: Text("Albums")) {
                    ForEach(viewModel.albums) { album in
                        NavigationLink {
                            LocalAlbumDetailView(album: album)
                        } label: {
                            LocalAlbumRowView(album: album)
                        }
                    }
                }
                Section(header: Text("Songs")) {
                    ForEach(viewModel.songs) { song in
                        NavigationLink {
                            LocalSongsDetailView(song: song)
                        } label: {
                            LocalSongsRowView(viewModel: LocalSongsForAlbumListViewModel(albumID: 0), song: song)
                        }
                    }
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
            .font(.body)
            
            .listStyle(.plain)
        }
        .font(.title)
        .navigationTitle("Local music")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            //viewModel.loadMore()
        }
    }
        
    
}

//struct LocalMusicListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            LocalMusicListView()
//                .environmentObject(viewModel: LocalListViewModel().loadMock())
//        }
//    }
//}
