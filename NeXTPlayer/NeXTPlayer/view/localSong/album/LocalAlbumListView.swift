//
//  LocalAlbumListView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 09/10/23.
//

import SwiftUI

struct LocalAlbumListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: LocalListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.artists, id: \.id) { artist in
                LocalArtistRowView(viewModel: viewModel, artist: artist)
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
            .foregroundColor(.black)
        })
    }
}

struct LocalAlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        LocalAlbumListView(viewModel: LocalListViewModel().loadMock())
    }
}
