//
//  LocalArtist.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 08/10/23.
//

import Foundation
import MusicKit
import MediaPlayer



struct LocalArtistResult: Codable {
    let resultCount: Int
    let results: [LocalArtist]
}

struct LocalArtist: Identifiable, Codable {
    let id: UUID
    let name: String?
    let genre: String?
//    let artist: MPMediaItem?
    let artworkUrl100: URL?
    let artistState: PlayerState
   
    
    init(artist: MPMediaItem, artistState: PlayerState) {
        self.id = UUID()
        self.name = artist.artist
        self.genre = artist.genre
//        self.artist = artist
        self.artworkUrl100 = artist.assetURL
        self.artistState = artistState
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        genre = try container.decodeIfPresent(String.self, forKey: .genre)
        artworkUrl100 = try container.decodeIfPresent(URL.self, forKey: .artworkUrl100)
        artistState = try container.decode(PlayerState.self, forKey: .artistState)
    }
   
    // Other parts of your struct

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case genre
        case artworkUrl100
        case artistState
    }
    
    // Implement the `encode(to:)` method
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(genre, forKey: .genre)
        try container.encode(artworkUrl100, forKey: .artworkUrl100)
        try container.encode(artistState.rawValue, forKey: .artistState)
    }
}

extension LocalArtist {

    
    static func mockData() -> [LocalArtist] {
        let artist0 = LocalArtist(artist: MockMediaItem(), artistState: .stop)
        let artist1 = LocalArtist(artist: MockMediaItem(), artistState: .stop)
        let artist2 = LocalArtist(artist: MockMediaItem(), artistState: .stop)
        print(artist1)
        return [artist0, artist1, artist2]
    }
}

class MockMediaItem: MPMediaItem {
    override func value(forProperty property: String) -> Any? {
        // Implement logic to return values for specific properties as needed
        if property == MPMediaItemPropertyTitle {
            return "Mock Song Title"
        } else if property == MPMediaItemPropertyArtist {
            return "Mock Artist Name"
        } else if property == MPMediaItemPropertyAssetURL {
            return URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/52/c0/4b/52c04bfb-7eb1-a158-1ac9-e1d4c82ce146/19UMGIM06727.rgb.jpg/100x100bb.jpg")
        } else if property == MPMediaItemPropertyArtwork {
            return "https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/52/c0/4b/52c04bfb-7eb1-a158-1ac9-e1d4c82ce146/19UMGIM06727.rgb.jpg/100x100bb.jpg"
        } else {
            // Handle other properties or return nil if not implemented
            return super.value(forProperty: property)
        }
    }
}
