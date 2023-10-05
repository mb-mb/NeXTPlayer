//
//  SearchAllListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 04/10/23.
//

import SwiftUI

struct SearchAllListView: View {
    
    @ObservedObject var albumViewModel: AlbumListViewModel
    @ObservedObject var songViewModel: SongsListViewModel
    @ObservedObject var movieViewModel: MovieListViewModel
    
    var body: some View {
        VStack {
            Text("Search all")
            
            Text("Movies: \(movieViewModel.movies.count)")
            Text("Albums: \(albumViewModel.albums.count)")
            Text("Songs: \(songViewModel.songs.count)")
        }
    }
}

struct SearchAllListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchAllListView(albumViewModel: AlbumListViewModel(),
                          songViewModel: SongsListViewModel(),
                          movieViewModel: MovieListViewModel())
    }
}
