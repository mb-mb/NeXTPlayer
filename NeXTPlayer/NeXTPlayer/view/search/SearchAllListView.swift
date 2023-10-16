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
                                }
                                .foregroundColor(Color("buttonNavColor"))
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
                                .foregroundColor(Color("buttonNavColor"))
                            }
                        }
                    }
                    .padding(.horizontal)
                    AlbumSectionView(albums: albumViewModel.albums)
                    Divider()
                        .padding(.bottom)
                    
                    if !(movieViewModel.movies.isEmpty) {
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
                                    .foregroundColor(Color("buttonNavColor"))
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        MovieSectionView(movies: movieViewModel.movies)
                        Divider()
                            .padding(.bottom)
                    } else {
                        Text("No data available")
                            .font(.caption)
                            .foregroundColor(Color("buttonNavColor"))
                    }
                }
                
            }
            
//            HStack(alignment: .bottom) {
//                Spacer()
//                SwiftUIBannerAd(adPosition: .bottom,
//                                adUnitId: SwiftUIMobileAds.testBannerId)
////                .padding(.bottom, 49)
//            }
//            //        .background(.green)
//            .frame(height: 50)
        }
    }
}

struct SearchAllListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchAllListView(albumViewModel: AlbumListViewModel().loadMock(),
                              songViewModel: SongsListViewModel().loadMock(),
                              movieViewModel: MovieListViewModel().loadMock())
        }
    }
}
