//
//  AlbumsViewGroup.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 20/10/21.
//

import SwiftUI

struct AlbumsViewGroup: View {
    @Environment(\.backgroundColorView) var backgroundColor
    @ObservedObject var viewModel: ContentViewModel
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
        self.imageLoader = ImageLoader(urlString:  "")
        UIScrollView.appearance().backgroundColor = UIColor(backgroundColor)        
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollView(.horizontal) {
                    HStack(alignment: .center, spacing: 0) {
                        ForEach(viewModel.albumsGroup, id: \.id) { album in
                            GeometryReader { proxy in
                                NavigationLink(
                                    destination: Image(uiImage: image),
                                    label: {
                                        let scale = getScale(proxy: proxy)
                                        AlbumsGroupRow(viewModel: viewModel, album: album, scale: scale)
                                    })
                                    .statusBar(hidden: true)

                            }
                            .background(Color.clear)
                            .accessibility(identifier: "songsList")
                            .frame(width:290, height: 200, alignment: .leading)
                            .padding(EdgeInsets(top: 20, leading: 85, bottom: 20, trailing: 2))
                            .cornerRadius(10)
                            .statusBar(hidden: true)
                            
                            
                        }
                        .background(Color.clear)
                        .frame(width: 210, height: 250)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 3))
                        
                    }
                    .cornerRadius(6)
                    .background(Color.clear)
                }
                .cornerRadius(6)
                .padding(3)
                .background(Color.clear)
            }
            .navigationTitle(viewModel.albumsGroup[0].artist[0].name)
        }
        .ignoresSafeArea(.all)
        
    }
    
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        let x = proxy.frame(in: .global).minX - 100
        let diff = abs(x - 32)
        if diff < 100 {
            scale = 1 + (120 - diff) / 400
        }
        return scale
    }

    
    
    
}

struct AlbumsViewGroup_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsViewGroup(viewModel: ContentViewModel(stateMachine: StateMachine(state: .group)))
    }
}

struct AlbumsGroupRow: View {
    @ObservedObject var viewModel: ContentViewModel
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    @Environment(\.albumListColor) var albumListColor
    @Environment(\.fontNextPlayer) var fontNextPlayer
    @Environment(\.sizeForSongs) var sizeForSongs
    var scale: CGFloat
    var album: Albums
    
    init(viewModel: ContentViewModel, album: Albums, scale: CGFloat) {
        self.imageLoader = ImageLoader(urlString: album.albumImage?.description ?? "")
        self.scale = scale
        self.album = album
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Image(uiImage:image)
                .resizable()
                .scaledToFill()
                .frame(width: 180, height: 150)
                .overlay(
                    RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5)
                )
//                .clipped()
                .onTapGesture {
                    viewModel.album = album
                    viewModel.state = .detail
                    

                }
                .cornerRadius(5)
                .shadow(radius: 4)
                .scaleEffect(CGSize(width: scale , height: scale))
                .animation(.easeOut(duration:0.5))
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                .onReceive(imageLoader.didChange) { data in
                    self.image = UIImage(data: data) ?? UIImage()
                }
            


            Text(album.albumName)
                .padding(.top, 15)
                .foregroundColor(Color.black)
        }
        .background(Color.clear)
        .statusBar(hidden: true)
    }
    
       
}

//struct AlbumsGroupRow_Previews: PreviewProvider {
//    static var previews: some View {
//
//        AlbumsGroupRow(album: Artist.artistAlbumData())
//    }
//}



