//
//  ImageLoadingView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 05/10/23.
//

import SwiftUI

struct ImageLoadingView: View {
    let urlString: String
    let size: CGFloat
    
    var body: some View {
        
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: size)
            case .failure(_):
                Color.gray
                    .frame(width: CGFloat(size/1.5),height: size)
            case .success(let image):
                image
                    .border(Color(white:0.8))
            @unknown default:
                EmptyView()
            }
        }
        .frame(height: size)
    }
}

struct ImageLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoadingView(urlString: "https://is1-ssl.mzstatic.com/image/thumb/Features115/v4/db/4b/0b/db4b0be4-02d9-c8ee-3ade-f44a6cdf5ae2/dj.eeqcsgup.jpg/60x60bb.jpg", size: 100)
    }
}
