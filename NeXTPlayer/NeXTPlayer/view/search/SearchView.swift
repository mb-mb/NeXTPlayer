//
//  SearchView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 04/10/23.
//

import SwiftUI

struct SearchView: View {
    @State private var searchTerm: String = ""
    @State private var selectEntityType = EntityType.all
    @StateObject private var albumViewModel = AlbumListViewModel()
    @StateObject private var songViewModel = SongsListViewModel()
    @StateObject private var movieViewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select the media", selection: $selectEntityType) {
                    ForEach(EntityType.allCases) { type in
                        Text(type.name())
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                Divider()
                
                if searchTerm.count == 0 {
                    SearchPlaceholderView(searchTerm: $searchTerm)
                        .frame(maxHeight: .infinity)
                } else {
                    switch selectEntityType {
                    case .all:
                        SearchAllListView(albumViewModel: albumViewModel,
                                          songViewModel: songViewModel,
                                          movieViewModel: movieViewModel)
                        .onAppear {
                            albumViewModel.searchTerm = searchTerm
                            songViewModel.searchTerm = searchTerm
                            movieViewModel.searchTerm = searchTerm
                        } 
                        Spacer()
                    case .album:
                        AlbumsListView(viewModel: albumViewModel)
                            .onAppear {
                                albumViewModel.searchTerm = searchTerm
                            }
                    case .song:
                        SongListView(viewModel: songViewModel)
                            .onAppear {
                                songViewModel.searchTerm = searchTerm
                            }
                    case .movie:
                        MovieListView(viewModel: movieViewModel)
                            .onAppear {
                                movieViewModel.searchTerm = searchTerm
                            }
                    }
                }
                HStack(alignment: .bottom) {
                    Spacer()
                    SwiftUIBannerAd(adPosition: .bottom,
                                    adUnitId: SwiftUIMobileAds.testBannerId)
                    .padding(.bottom, 15)
                }
                //        .background(.green)
                .frame(height: 50)
            }
            .searchable(text: $searchTerm)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: searchTerm) { newValue in
            switch selectEntityType {
            case .all:
                albumViewModel.searchTerm = newValue
                songViewModel.searchTerm = newValue
                movieViewModel.searchTerm = newValue
            case .album:
                albumViewModel.searchTerm = newValue
            case .song:
                songViewModel.searchTerm = newValue
            case .movie:
                movieViewModel.searchTerm = newValue
            }
        }

    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
