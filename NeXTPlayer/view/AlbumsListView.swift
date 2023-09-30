//
//  MainView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 12/10/21.
//

import SwiftUI

struct AlbumsListView: View {
    @Environment(\.backgroundColorView) var backgroundColor
    @ObservedObject var viewModel: ContentViewModel


    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
        UIScrollView.appearance().backgroundColor = UIColor(backgroundColor)
    }
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0.1) {
                ForEach(viewModel.artistList , id: \.id) { artist in
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text("\(artist.name)")
                            .font(.headline)
                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 0))
                            .accessibilityIdentifier("artistName")

                        Button(action: {
                            viewModel.fetchAlbums(from: artist.name)
                            viewModel.state = .group
                        }) {
                            Image(systemName: "menubar.rectangle")
                                .frame(width: 23, height: 23, alignment: .center)
                        }
                        .buttonStyle(ButtonMenu())
                        .accessibility(identifier: "buttonMenuChange")
                        Spacer()
                    }
                    .background(backgroundColor)
                    

                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack( spacing: 0.1) {
                            ForEach(artist.albums) { album in
                                AlbunsRow( item: album)
                                ForEach(album.songs, id: \.id) { songs in
                                    SongsRow(songsOf: songs)
                                }
                            }
                            .accessibility(identifier: "albunsList")
                            .border(Color.white, width: 0.5)
                            .padding(EdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3))
                            .cornerRadius(10)
                        }
                        .toolbar {
                            Text("tool bar")
                        }
                        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 0))
                        .edgesIgnoringSafeArea(.all)
                        .cornerRadius(1)
                    }
                    .background(backgroundColor)
                }
            }
        }
        .statusBar(hidden: true)

    }

}

struct AlbunsRow: View {
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    @Environment(\.albumListColor) var albumListColor
    @Environment(\.fontNextPlayer) var fontNextPlayer
    @Environment(\.sizeForSongs) var sizeForSongs

    var item: Albums

    init(item: Albums) {
        self.imageLoader = ImageLoader(urlString: item.albumImage?.description ?? "")
        self.item = item
    }
    
    var body: some View {
        HStack(spacing: 5){
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
                .onReceive(imageLoader.didChange) { data in
                    self.image = UIImage(data: data) ?? UIImage()
                }
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                .animation(.easeInOut)

            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("\(item.albumName)")
                        .font(.custom(fontNextPlayer, size: CGFloat(sizeForSongs), relativeTo: .headline))
                        .padding(EdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2))
                }
                .frame(width: 178, height: 25, alignment: .leading)
                .background(Color.gray)
                .border(Color.black.opacity(0.2), width: 0.5)
                .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                    
                HStack {
                    Text("\(item.albumName)")
                        .font(.custom(fontNextPlayer, size: CGFloat(sizeForSongs), relativeTo: .headline))
                        .padding(EdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2))
                }
                .frame(width: 178, height: 38, alignment: .leading)
                .background(Color.gray)
                .border(Color.black.opacity(0.2), width: 0.5)
                .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                HStack {
                    Text("\(Date(), formatter: itemFormatter)")
                        .font(.custom(fontNextPlayer, size: CGFloat(sizeForSongs), relativeTo: .headline))
                        .padding(EdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2))
                }
                .frame(width: 178, height: 25, alignment: .leading)
                .background(Color.gray)
                .border(Color.black.opacity(0.2), width: 0.5)
                .padding(EdgeInsets(top: 2, leading: 2, bottom:2, trailing: 2))

            }
        }
        .accessibility(identifier: "songsList")
        .frame(width: 288, height: 100, alignment: .leading)
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 2))
        .cornerRadius(10)
        .background(albumListColor)
    }
}


struct SongsRow: View {
    @Environment(\.albumListColor) var albumListColor
    @Environment(\.fontNextPlayer) var fontNextPlayer
    @Environment(\.sizeForSongs) var sizeForSongs

    var songsOf: Songs

    init(songsOf: Songs) {
        self.songsOf = songsOf
    }
    
    var body: some View {
        HStack(spacing: 5){
            VStack(alignment: .leading) {
                
                VStack (alignment: .leading) {
                    HStack {
                        HStack {
                            Text("position ")
                                .font(.custom(fontNextPlayer, size: 10, relativeTo: .headline))
                                .multilineTextAlignment(.leading)
                                .frame(width: 45, height: 25, alignment: .leading)
                                .foregroundColor(Color.black.opacity(0.5))
                                .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2))
                            Text("\(songsOf.albumPosition)")
                                .font(.custom(fontNextPlayer, size: CGFloat(sizeForSongs), relativeTo: .headline))
                                .multilineTextAlignment(.leading)
                                .frame(width: 20, height: 25, alignment: .leading)
                        }
                        .frame(width: 70, height: 25, alignment: .leading)
                        .background(Color.gray)
//                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2))
                        .border(Color.black.opacity(0.2), width: 0.5)

                        
                        HStack {
                            Text("duration ")
                                .font(.custom(fontNextPlayer, size: 10, relativeTo: .headline))
                                .multilineTextAlignment(.leading)
                                .frame(width: 45, height: 25, alignment: .leading)
                                .foregroundColor(Color.black.opacity(0.5))
                                .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2))
                            Text("\(durationFormatter(duration: songsOf.duration))\"")
                                .font(.custom(fontNextPlayer, size: CGFloat(sizeForSongs), relativeTo: .headline))
                                .frame(width: 45, height: 25, alignment: .leading)
                        }
                        .frame(width: 112, height: 25, alignment: .leading)
                        .background(Color.gray)
//                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 2))
                        .border(Color.black.opacity(0.2), width: 0.5)

                    }
//                    .background(Color.gray)
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 1, trailing: 5))
//                    .border(Color.black.opacity(0.2), width: 0.5)

                    HStack {
                        Text("\(songsOf.id)")
                            .font(.custom(fontNextPlayer, size: CGFloat(sizeForSongs), relativeTo: .headline))
                            .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0))
                    }
                    .frame(width: 190, height: 60, alignment: .leading)
                    .background(Color.gray)
                    .padding(EdgeInsets(top: 0.2, leading: 0, bottom: 0.5, trailing: 0))
                    .border(Color.black.opacity(0.2), width: 0.5)
                }
                
            }
        }
        .frame(width: 190, height: 105, alignment: .leading)
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
        .cornerRadius(10)
        .background(albumListColor)
    }
    
    func durationFormatter(duration: Float) -> String {
        return String(format: "%.2f", duration)
    }
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = "dd'/'MM'/'yy"
//    formatter.timeStyle = .medium
    return formatter
}()



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsListView(viewModel: ContentViewModel(stateMachine: StateMachine(state: .config)))
    }
}
