//
//  LocalAlbumDetailView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 06/10/23.
//

import SwiftUI

struct LocalAlbumDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var localViewModel: LocalSongsForAlbumListViewModel
    let album: LocalAlbum
    
    init( album: LocalAlbum) {
        self.album = album
        self._localViewModel = StateObject(wrappedValue:
                                            LocalSongsForAlbumListViewModel(albumID: album.id))
    }
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {

                if let image = UIImage(data: album.artwork) {
                    Image(uiImage: image )
                        .resizable()
                        .frame(width:100, height: 100)
                        .cornerRadius(8)
                } else {
                    Image(systemName: "music.note.house")
                        .frame(width:100, height: 100)
                }
                VStack(alignment: .leading) {
                    Text(album.collectionName)
                        .font(.footnote)
                        .foregroundColor(Color(.label))
                    Text(album.artistName ?? "")
                        .padding(.bottom, 5)
                    
                    Text(album.primaryGenreName)
                    Text("\(album.trackCount) songs")
                              
                    Text("Released: \(String.formattedDate(value: album.releaseDate))")
                }
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)
                Spacer(minLength: 20)
            }
            .padding()
            LocalSongsForAlbumListView(songsViewModel: localViewModel)
        }
        .onAppear {
//            localViewModel.fetch()
        }
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

struct LocalAlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocalAlbumDetailView(album: LocalAlbum.mockData().first!)
        }
    }
}
