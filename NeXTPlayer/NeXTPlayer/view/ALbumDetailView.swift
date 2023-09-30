//
//  PlayingNowView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 04/11/21.
//

import SwiftUI

struct ALbumDetailView: View {
    @ObservedObject var viewModel: ContentViewModel
    @Environment(\.fontNextPlayer) var fontNextPlayer
    @Environment(\.backgroundColorView) var backgroundColor
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    var album: Albums
    
    init(viewModel: ContentViewModel) {
        self.imageLoader = ImageLoader(urlString: "")
        self.album = viewModel.album
        self.viewModel = viewModel
        UIScrollView.appearance().backgroundColor = UIColor(backgroundColor)
    }
    
    var body: some View {
        VStack {
            VStack {
                Button {
                    viewModel.state = .start
                }
                label: {
                    Text("get back")
                        .font(.custom(fontNextPlayer, size: CGFloat(16), relativeTo: .headline))
                        .background(Color.clear)
                }
            }
            .frame(width: 380, height: 17, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0 ))
            .buttonStyle(ButtonMenu())
            .accessibility(identifier: "buttonMenuChangeStart")
            .background(Color.clear)
            .ignoresSafeArea()

        NavigationView {
                
                ScrollView {
                    ScrollView(.horizontal) {
                        HStack(alignment: .center, spacing: 0) {
                            GeometryReader { proxy in
                                NavigationLink(
                                    destination: Image(uiImage: image),
                                    label: {
                                        let scale = getScale(proxy: proxy)
                                        AlbumDetailViewNow(viewModel: viewModel, scale: scale)
                                    })
                                    .statusBar(hidden: true)
                            }
                            .background(Color.clear)
                            .accessibility(identifier: "songsList")
                            .frame(width:290, height: 200, alignment: .leading)
                            .padding(EdgeInsets(top: 50, leading: 85, bottom: 20, trailing: 20))
                            .cornerRadius(10)
                            .statusBar(hidden: true)
                            
                        }
                    }
                    
                    // album detail
                    ScrollView(.vertical) {
                        VStack(alignment: .leading, spacing: 6) {
                            //                        VStack(alignment: .leading, spacing: 1) {
                            //                        Text(viewModel.album.artist[0].name)
                            //                            .font(.headline)
                            //                        }
                            //                        .frame(width: 300, height: 50, alignment: .center)
                            //                        .background(Color.gray.opacity(0.5))
                            //                        .padding(5)
                            //
                            //                        VStack(alignment: .leading, spacing: 1) {
                            //                            Text("album")
                            //                                .font(.custom(fontNextPlayer, size: CGFloat(6), relativeTo: .headline))
                            //
                            //                        }
                            
                            //                        VStack(alignment: .leading, spacing: 1) {
                            //                            Text(viewModel.album.albumName)
                            //                                .font(.title2)
                            //                        }
                            //                        .frame(width: 300, height: 50, alignment: .leading)
                            //                        .background(Color.gray.opacity(0.5))
                            //                        .padding(5)
                            
                            VStack(alignment: .leading, spacing: 1) {
                                Text("Songs")
                                    .font(.custom(fontNextPlayer, size: CGFloat(6), relativeTo: .headline))
                                
                            }
                            VStack(alignment: .leading, spacing: 1) {
                                Text(viewModel.album.songs[0].name)
                                    .font(.title3)
                                Text("4:45''")
                                    .font(.subheadline)
                            }
                            .frame(width: 300, height: 50, alignment: .leading)
                            .background(Color.gray.opacity(0.5))
                            .padding(5)
                            
                            
                            VStack(alignment: .leading, spacing: 1) {
                                Text(viewModel.album.songs[1].name)
                                    .font(.title3)
                                Text("4:45''")
                                    .font(.subheadline)
                            }
                            .frame(width: 300, height: 50, alignment: .leading)
                            .background(Color.gray.opacity(0.5))
                            .padding(5)
                            
                            
                            VStack(alignment: .leading, spacing: 1) {
                                Text(viewModel.album.songs[2].name)
                                    .font(.title3)
                                Text("4:45''")
                                    .font(.subheadline)
                            }
                            .frame(width: 300, height: 50, alignment: .leading)
                            .background(Color.gray.opacity(0.5))
                            .padding(5)
                            
                            
                        }
                    }
                }
                .padding(0)
                .navigationTitle(album.artist[0].name)
                
            }
        }
        
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

struct PlayingNowView_Previews: PreviewProvider {
    static var previews: some View {
        ALbumDetailView(viewModel: ContentViewModel(stateMachine: StateMachine(state: .detail)))
    }
}


struct AlbumDetailViewNow: View {
    @ObservedObject var viewModel: ContentViewModel
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    @Environment(\.albumListColor) var albumListColor
    @Environment(\.fontNextPlayer) var fontNextPlayer
    @Environment(\.sizeForSongs) var sizeForSongs
    var scale: CGFloat
    
    init(viewModel: ContentViewModel, scale: CGFloat) {
        self.viewModel = viewModel
        self.imageLoader = ImageLoader(urlString: viewModel.album.albumImage?.description ?? "")
        self.scale = scale
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
                .cornerRadius(5)
                .shadow(radius: 4)
                .scaleEffect(CGSize(width: scale , height: scale))
                .animation(.easeOut(duration:0.5))
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                .onReceive(imageLoader.didChange) { data in
                    self.image = UIImage(data: data) ?? UIImage()
                }
            
            
            Text(viewModel.album.albumName)
                .padding(.top, 15)
                .foregroundColor(Color.black)
        }
        .background(Color.clear)
        .statusBar(hidden: true)
    }
    
    
}
