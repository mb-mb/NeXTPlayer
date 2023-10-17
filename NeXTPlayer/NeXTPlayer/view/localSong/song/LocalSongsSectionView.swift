//
//  LocalSongsSectionView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 09/10/23.
//

import SwiftUI

struct LocalSongsSectionView: View {
    @EnvironmentObject var viewModel: LocalListViewModel
    let cols = GridItem(.fixed(110), spacing:0, alignment: .leading)
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [cols] ) {
                LocalSongsListView()
                    .environmentObject(viewModel)
            }
        }
    }
}

//struct LocalSongsSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocalSongsSectionView(viewModel: LocalListViewModel().loadMock())
//    }
//}
