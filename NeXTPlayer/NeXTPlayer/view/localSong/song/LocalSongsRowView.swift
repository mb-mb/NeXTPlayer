//
//  LocalSongsRowView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 08/10/23.
//

import SwiftUI

struct LocalSongsRowView: View {
    @ObservedObject var viewModel: LocalSongsForAlbumListViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var song: LocalSong
    
   
    var body: some View {
        
        
        HStack {
            Button {
                viewModel.play(song: song)
            } label: {
                Image(systemName: viewModel.songState(for: song))
                    .font(.largeTitle)
                    .frame(width: 48, height: 42)
                    .background(Color.black.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .foregroundColor(.orange)
            }
            .foregroundColor(Color("buttonNavColor"))
//            .padding()
            
            Text("\(song.trackName)-\( song.id)")
                .gridColumnAlignment(.leading)
                .font(.caption)
                .frame(width: 250, alignment: .leading)
                .padding(.leading, 5)
            //                            .background(Color.gray)
            if let timeLabel = viewModel.songTimeLabel(for: song) {
                Text(timeLabel)
                    .frame(width: 35, alignment: .leading)
                    .font(.caption)
                    .foregroundColor(Color.blue)
                    .padding(.trailing)
            } else {
                Text(song.trackDuration)
                    .frame(width: 35, alignment: .leading)
                    .font(.caption)
                    .padding(.trailing)
            }
        }
        .navigationBarBackButtonHidden(true)
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
    }
}

struct LocalSongsRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocalSongsRowView(viewModel: LocalSongsForAlbumListViewModel(albumID: 0), song: LocalSong.mock().first!)
        }
    }
}
