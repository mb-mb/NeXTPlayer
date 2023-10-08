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
        NavigationView {
            List {
                Section(header: Text("Artists")) {
                    ForEach(viewModel.artists) { artists in
                        NavigationLink {
                            LocalArtistDetailView(artist: artists)
                        } label: {
                            LocalArtistRowView(artist: artists)
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
                    ForEach(viewModel.songs) { songs in
                        NavigationLink {
                            LocalSongsDetailView(album: songs)
                        } label: {
                            LocalSongsRowView(album: songs)
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
    }
    
}

struct LocalMusicListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocalMusicListView(viewModel: LocalListViewModel().loadMock())
        }
    }
}
