//
//  AlbumDetailView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 05/10/23.
//

import SwiftUI

struct AlbumDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var songsViewModel: SongsForAlbumListViewModel
    let album: Album
    
    init( album: Album) {
        self.album = album
        self._songsViewModel = StateObject(wrappedValue: SongsForAlbumListViewModel(albumID: album.id))
    }
    
    var body: some View {
        VStack(spacing: 10){
            HStack(alignment: .bottom) {
                ImageLoadingView(urlString: album.artworkUrl100, size: 100)
                    .cornerRadius(1)
                    .padding([.leading, .top])
                    
                VStack(alignment: .leading) {
                    Text(album.collectionName)
                        .font(.footnote)
                        .foregroundColor(Color(.label))
                    Text(album.artistName)
                        .padding(.bottom, 5)
                    
                    Text(album.primaryGenreName)
                    Text("\(album.trackCount) songs")
                    
                    Text("Released: \(String.formattedDate(value: album.releaseDate))")
                }
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)
                Spacer(minLength: 20)
                BuyButton(urlString: album.collectionViewURL,
                          price: album.collectionPrice,
                          currency: album.currency)
                        .padding(.trailing, 10)
            }
            .frame(height: 80)
            .padding(.bottom, 15)            
            SongsForAlbumListView(songsViewModel: songsViewModel)
        }
        .onAppear {
            songsViewModel.fetch()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrowshape.turn.up.backward.fill")              
                    .font(.caption)
                    .frame(width: 28, height: 32)
                //                    .background(Color.black.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                Text("back")
                    .font(.caption2)
            }
            .foregroundColor(Color("buttonNavColor"))
        })
        Spacer()
        
    }
    

}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AlbumDetailView(album: Album.example())
        }
    }
}
