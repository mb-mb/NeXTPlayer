//
//  LocalALbumRowView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 06/10/23.
//

import SwiftUI
import UIKit

struct LocalAlbumRowView: View {
    
    let album: LocalAlbum
    var body: some View {
        HStack {
            
            NavigationLink {
                LocalAlbumDetailView(album: album)
            } label: {
                Group {
                    HStack {
                        ArtWorkView(artWork: album.artwork)
                        
                        VStack(alignment: .leading) {
                            Text(album.collectionName)
                            Text(album.artistName ?? "")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        //            .frame(width: 150, height: 70)
                        .lineLimit(1)
                        .padding([.bottom, .top])
                        //            .background(Color.gray)
                    }
                    Spacer(minLength: 20)
                }
            }
        }
    }

}

struct ArtWorkView: View {
    
    var artWork: Data
    
    var body: some View {
        VStack {
            if let uiImage = UIImage(data: artWork) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
            } else {
                Image(systemName: "music.note.house")
                    .frame(width: 100, height: 100)
            }
        }
    }
    
}

struct LocalALbumRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocalAlbumRowView(album: LocalAlbum.mockData().first!)
        }
    }
}
