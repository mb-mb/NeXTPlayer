//
//  LocalALbumRowView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 06/10/23.
//

import SwiftUI

struct LocalAlbumRowView: View {
    
    let album: LocalAlbum
    var body: some View {
        HStack {
            
            NavigationLink {
                LocalAlbumDetailView(album: album)
            } label: {
                Group {
                    if let data = album.artwork,
                    let image = UIImage(data: data) {
                        Image(uiImage: image )
                            .resizable()
                            .frame(width:100, height: 100)
                            .cornerRadius(8)
                    } else {
                        Image(systemName: "music.note.house")
                            .frame(width:100, height: 100)
                    }
                    VStack(alignment: .leading) {
                        Text(album.album.collectionName)
                        Text(album.album.artistName)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    //            .frame(width: 150, height: 70)
                    .lineLimit(1)
                    //            .padding()
                    //            .background(Color.gray)
                    Spacer(minLength: 20)
                }
            }
            
            
        }
    }
}

struct LocalALbumRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LocalAlbumRowView(album: LocalAlbum.mockData().first!)
        }
    }
}
