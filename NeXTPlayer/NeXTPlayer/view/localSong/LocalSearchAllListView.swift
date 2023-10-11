//
//  LocalSearchAllListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 09/10/23.
//

import SwiftUI

struct LocalSearchAllListView: View {
    @ObservedObject var localViewModel: LocalListViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                
                HStack {
                    Text("Artist")
                        .font(.title2)
                    Spacer()
                    NavigationLink {
                        LocalArtistListView(viewModel: localViewModel)
                    } label: {
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
                .padding(.horizontal)                
                LocalArtistSectionView(viewModel: localViewModel)
                Divider()
                    .padding(.bottom)
                
                HStack {
                    Text("Albums")
                        .font(.title2)
                    Spacer()
                    NavigationLink {
                        LocalAlbumListView(viewModel: localViewModel)
                    } label: {
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
                .padding(.horizontal)
                LocalAlbumSectionView(viewModel: localViewModel)
                Divider()
                    .padding(.bottom)

                
                HStack {
                    Text("Songs")
                        .font(.title2)
                    Spacer()
                    NavigationLink {
                        LocalSongsListView(viewModel: localViewModel)
                    } label: {
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
                .padding(.horizontal)
                LocalSongsSectionView(viewModel: localViewModel)
                Divider()
                    .padding(.bottom)
                
                
            }
        }
    }
}

struct LocalSearchAllListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocalSearchAllListView(localViewModel: LocalListViewModel().loadMock())
        }
    }
}
