//
//  LocalAlbumListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 09/10/23.
//

import SwiftUI

struct LocalAlbumListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: LocalListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.albums, id: \.id) { album in
                LocalAlbumRowView(album: album)
                    .environmentObject(viewModel)
            }
            switch viewModel.state {
            case .good:
                EmptyView()
            case .isLoading:
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity)
            case .loadedAll:
                EmptyView()
            case .error(let message):
                Text(message)
                    .foregroundColor(.pink)
            }
            
        }
        .listStyle(.plain)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrowshape.turn.up.backward.fill")              .font(.caption)
                    .frame(width: 28, height: 32)
//                    .background(Color.black.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                Text("back")
                    .font(.caption2)
            }
            .foregroundColor(Color("buttonNavColor"))
        })
    }
}


struct LocalAlbumListView_Preview:  PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocalAlbumListView()
                .environmentObject(LocalViewModelView.viewModel)
        }
    }
}
