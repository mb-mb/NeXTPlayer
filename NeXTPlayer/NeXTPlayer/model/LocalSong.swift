//
//  LocalSong.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 06/10/23.
//

import Foundation

// MARK: - SonResult
struct LocalSongResult: Codable {
    let resultCount: Int
    let results: [Song]
}

struct LocalSong: Identifiable {
    var id: UUID
    let song: Song
    var songState: PlayerState
    
    
    init(song: Song, songState: PlayerState) {
        self.id = song.uuid
        self.song = song
        self.songState = songState
    }

    static func example() -> LocalSong {
        
        let song = Song(wrapperType: "Song",
             artistID: 1, collectionID: 1, id: 1, artistName: "Jack Johnson",
             collectionName: "Jack Johnson and Friends: Sing-A-Longs and Lullabies for the Film Curious George",
             trackName: "Upside Down", artistViewURL: "", collectionViewURL: "", trackViewURL: "https://music.apple.com/us/album/upside-down/1469577723?i=1469577741&uo=4", previewURL: "https://is3-ssl.mzstatic.com",
             artworkUrl30: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/30x30bb.jpg", artworkUrl60: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/60x60bb.jpg", artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/100x100bb.jpg", collectionPrice: 9.88, trackPrice: 1.29, releaseDate: "2005-01-01T12:00:00Z", trackCount: 14, trackNumber: 1, trackTimeMillis: 208643, country: "USA", currency: "USD", primaryGenreName: "Rock", collectionArtistName: nil)
        return LocalSong(song: song, songState: .stop)
    }

}


