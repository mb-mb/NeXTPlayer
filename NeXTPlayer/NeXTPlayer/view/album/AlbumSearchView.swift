//
//  AlbumSearchView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 03/10/23.
//

import SwiftUI

struct AlbumSearchView: View {
    @StateObject var viewModel = AlbumListViewModel()
    var body: some View {
        NavigationView {
            Group {
                Spacer()
                if viewModel.searchTerm.isEmpty {
                    SearchPlaceholderView(searchTerm: $viewModel.searchTerm)
                } else {
                    AlbumsListView(viewModel: viewModel)
                }
                Spacer()
                HStack(alignment: .bottom) {
                    Spacer()
                    SwiftUIBannerAd(adPosition: .bottom,
                                    adUnitId: SwiftUIMobileAds.testBannerId)
                    .padding(.bottom, 15)
                }
                //        .background(.green)
                .frame(height: 50)
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Albums")
        }
    }
        
}



struct AlbumSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSearchView()
    }
}
