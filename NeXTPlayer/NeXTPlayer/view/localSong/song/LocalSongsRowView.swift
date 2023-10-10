//
//  LocalSongsRowView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 08/10/23.
//

import SwiftUI

struct LocalSongsRowView: View {
    var song: LocalSong
    
    var body: some View {
        
        HStack {
            Text("\(song.trackName)") 
                .gridColumnAlignment(.leading)
                .font(.caption)
                .frame(width: 250, alignment: .leading)
            //                            .background(Color.gray)
            Text(song.trackDuration)
                .font(.caption)            
                .padding(.trailing)
        }
    }
}

struct LocalSongsRowView_Previews: PreviewProvider {
    static var previews: some View {
        LocalSongsRowView(song: LocalSong.mock().first!)
    }
}
