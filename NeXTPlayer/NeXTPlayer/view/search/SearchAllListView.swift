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
        ScrollView {
            LazyVStack {
                
                HStack {
                    Text("Songs")
                        .font(.title2)
                    Spacer()
                    NavigationLink {
                        SongListView(viewModel: songViewModel)
                    } label: {
                        HStack {
                            HStack {
                                Text("See all")
                                    .font(.caption2)
                                Image(systemName: "arrowshape.turn.up.right.fill")
                                    .font(.caption)
                              .frame(width: 18, height: 32)
                              .clipShape(RoundedRectangle(cornerRadius: 6))
                              .foregroundColor(.black)
                            }
                            .foregroundColor(.black)
                        }
                    }
                }
                .padding(.horizontal)
                SongSectionView(viewModel: songViewModel)
                
                Divider()
                    .padding(.bottom)
                
                HStack {
                    Text("Albums")
                        .font(.title2)
                    Spacer()
                    NavigationLink {
                        AlbumsListView(viewModel: albumViewModel)
                    } label: {
                        HStack {
                            HStack {
                                Text("See all")
                                    .font(.caption2)
                                Image(systemName: "arrowshape.turn.up.right.fill")
                                    .font(.caption)
                              .frame(width: 18, height: 32)
                              .clipShape(RoundedRectangle(cornerRadius: 6))
                            }
                            .foregroundColor(.black)
                        }
                    }
                }
                .padding(.horizontal)
                AlbumSectionView(albums: albumViewModel.albums)
                Divider()
                    .padding(.bottom)
                
                HStack {
                    Text("Movies")
                        .font(.title2)
                    Spacer()
                    NavigationLink {
                        MovieListView(viewModel: movieViewModel)
                    } label: {
                        HStack {
                            HStack {
                                Text("See all")
                                    .font(.caption2)
                                Image(systemName: "arrowshape.turn.up.right.fill")
                                    .font(.caption)
                              .frame(width: 18, height: 32)
                              .clipShape(RoundedRectangle(cornerRadius: 6))
                            }
                            .foregroundColor(.black)
                        }
                    }
                }
                .padding(.horizontal)
                
                MovieSectionView(movies: movieViewModel.movies)
                Divider()
                    .padding(.bottom)
            }
        }
    }
}

struct SearchAllListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchAllListView(albumViewModel: AlbumListViewModel().loadMock(),
                          songViewModel: SongsListViewModel().loadMock(),
                          movieViewModel: MovieListViewModel().loadMock())
    }
}
