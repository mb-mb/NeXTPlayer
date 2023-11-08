//
//  LocalSearchAllListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 09/10/23.
//

import SwiftUI

struct LocalSearchAllListView: View {
    @EnvironmentObject var localViewModel: LocalListViewModel
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {                    
                    HStack {
                        Text("Artist")
                            .font(.title2)
                        Spacer()
                        NavigationLink {
                            LocalArtistListView()
                                .environmentObject(localViewModel)
                        } label: {
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
                    .padding(.horizontal)
                    LocalArtistSectionView()
                        .environmentObject(localViewModel)
                    Divider()
                        .padding(.bottom)
                    
                    HStack {
                        Text("Albums")
                            .font(.title2)
                        Spacer()
                        NavigationLink {
                            LocalAlbumListView()
                                .environmentObject(localViewModel)
                        } label: {
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
                    .padding(.horizontal)
                    LocalAlbumSectionView()
                        .environmentObject(localViewModel)
                    Divider()
                        .padding(.bottom)
                    
                    
                }
                .onAppear {
                    localViewModel.loadMore()
                }
                .onChange(of: searchTerm) { newValue in
                    localViewModel.searchTerm = newValue
                }
            }
            .searchable(text: $searchTerm)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LocalSearchAllListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocalSearchAllListView()
                .environmentObject(LocalListViewModel().loadMock())
        }
    }
}
