//
//  LocalSong.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 06/10/23.
//

import Foundation
import MediaPlayer


struct ID<T>: Equatable, Identifiable {
    let id = UUID()
}

// MARK: - SonResult
struct LocalSongResult: Codable {
    let resultCount: Int
    let results: [LocalSong]
}

struct LocalSong: Identifiable, Codable {
    var id: UUID
    var trackName: String
    var trackURL: URL?
    var songState: PlayerState
    let trackDuration: String
    let trackNumber: Int
    
    
    init(song: MPMediaItem, songState: PlayerState) {
        self.id = UUID()
        self.trackName = song.title ?? "-.-"
        self.trackURL = song.assetURL
        self.songState = songState
        self.trackDuration = song.playbackDuration.formatTime()
        self.trackNumber = song.albumTrackNumber
    }

    enum CodingKeys: String, CodingKey {
        case id
        case trackName
        case trackURL
        case songState
        case trackDuration
        case trackNumber
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        trackName = try container.decode(String.self, forKey: .trackName)
        trackURL = try container.decodeIfPresent(URL.self, forKey: .trackURL)
        songState = try container.decode(PlayerState.self, forKey: .songState)
        trackDuration = try container.decode(String.self, forKey: .trackDuration)
        trackNumber = try container.decode(Int.self, forKey: .trackNumber)
    }
    
    // Implement the `encode(to:)` method
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(trackName, forKey: .trackName)
        try container.encode(trackURL, forKey: .trackURL)
        try container.encode(songState.rawValue, forKey: .songState)
        try container.encode(trackDuration, forKey: .trackDuration)
        try container.encode(trackNumber, forKey: .trackNumber)
    }

    
}

//trackViewURL: "https://music.apple.com/us/album/upside-down/1469577723?i=1469577741&uo=4", previewURL: "https://is3-ssl.mzstatic.com",

//artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/100x100bb.jpg",


extension LocalSong {
    
    static func mock() -> [LocalSong] {

        let song0 = LocalSong(song: MockMediaItem(), songState: .stop)
        let song1 = LocalSong(song: MockMediaItem(), songState: .stop)
        let song2 = LocalSong(song: MockMediaItem(), songState: .stop)
        
        return [song0, song1, song2 ]
    }

}


