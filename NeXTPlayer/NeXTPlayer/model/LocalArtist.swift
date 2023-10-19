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
    let id: UInt64
    let name: String?
    let genre: String?
    let artwork: Data
    let artistState: PlayerState
   
    
    init(artist: MPMediaItem, artistState: PlayerState) {
        self.id = artist.persistentID
        self.name = artist.artist
        self.genre = artist.genre
        if let artWork = artist.artwork,
            let data = artWork.image(at: CGSize(width: 100, height: 100))?.pngData() {
            self.artwork = data
        } else {
            let im = UIImage(systemName: "music.mic.circle")!
            self.artwork = im.pngData()!
        }
        self.artistState = artistState
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UInt64.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        genre = try container.decodeIfPresent(String.self, forKey: .genre)
        artwork = try container.decode(Data.self, forKey: .artwork)
        artistState = try container.decode(PlayerState.self, forKey: .artistState)
    }
   
    // Other parts of your struct

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case genre
        case artwork
        case artistState
    }
    
    // Implement the `encode(to:)` method
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(genre, forKey: .genre)
        try container.encode(artwork, forKey: .artwork)
        try container.encode(artistState.rawValue, forKey: .artistState)
    }
}

extension LocalArtist {
    static func mockData() -> [LocalArtist] {

        let mockMPMediaItem = MockMediaItem()
        mockMPMediaItem.mockArtist = "Artist Name One"
        mockMPMediaItem.mockGenre = "Pop"
//        mockMPMediaItem.mockArtwork = MPMediaItemArtwork(boundsSize: CGSize(width: 100, height: 100), requestHandler: { size in
//            return UIImage(systemName: "music.mic.circle")!
//        })

        mockMPMediaItem.mockArtwork = MPMediaItemArtwork(boundsSize: CGSize(width: 100, height: 100), requestHandler: { size in
                        return makeFakeImage(index: 0)
                    })
        
        let artist0 = LocalArtist(
            artist: mockMPMediaItem,
            artistState: .stop)

        mockMPMediaItem.mockArtist = "Artist Name 2"
        mockMPMediaItem.mockArtwork = MPMediaItemArtwork(boundsSize: CGSize(width: 100, height: 100), requestHandler: { size in
                        return makeFakeImage(index: 1)
                    })

        let artist1 = LocalArtist(
            artist: mockMPMediaItem, artistState: .stop)
        
        mockMPMediaItem.mockArtist = "Artist Name 3"
        mockMPMediaItem.mockArtwork = MPMediaItemArtwork(boundsSize: CGSize(width: 100, height: 100), requestHandler: { size in
                        return makeFakeImage(index: 2)
                    })

        let artist2 = LocalArtist(
            artist: mockMPMediaItem, artistState: .stop)
        
        return [artist0, artist1, artist2]
        
    }
}

class MockMediaItem: MPMediaItem {
    var mockPersistentID: MPMediaEntityPersistentID = 0
    var mockArtist: String?
    var mockGenre: String?
    var mockArtwork: MPMediaItemArtwork?
    var mockCollectionName: String?
    var mockAlbumPersistentID: UInt64?
    var mockArtistPersistentID: UInt64?
    var mockReleaseDate: Date?
    var mockAlbumTrackCount: Int = Int.random(in: 6...12)
    var mockTrackNumber: Int?
    var mockAlbumTrackNumber: Int?
    
    override var persistentID: MPMediaEntityPersistentID {
        return UInt64.random(in: 0...99)
//        return mockPersistentID
    }
    override var artist: String? {
        return mockArtist
    }

    override var title: String? {
        return mockCollectionName
    }

    override var genre: String? {
        return mockGenre
    }
    
    override var albumPersistentID: UInt64 {
        return mockAlbumPersistentID ?? UInt64.random(in: 0...99)
    }
    override var artistPersistentID: UInt64 {
        return mockArtistPersistentID ?? UInt64.random(in: 0...99)
    }
    override var releaseDate: Date? {
        return Date() // "yyyy-MM-dd'T'HH:mm:ss'Z'"
//        return mockReleaseDate
    }
    override var albumTrackCount: Int {
        return mockAlbumTrackCount
    }

    var trackURL: URL? {
        return URL(string: "https://music.apple.com/us/album/upside-down/1469577723?i=1469577741&uo=4")!
    }
    
    override var assetURL: URL? {
        return URL(string: "https://music.apple.com/us/album/upside-down/1469577723?i=1469577741&uo=4")!
    }
    
    var trackDuration: String {
        return "03:54"
    }
    
    var trackNumber: Int {
        return mockTrackNumber ?? 1
    }

    override var albumTrackNumber: Int {
        return mockAlbumTrackNumber ?? 1
    }

    var trackName: String {
        return "track name"
    }

    override var artwork: MPMediaItemArtwork? {
        return mockArtwork
    }
    
    override var playbackDuration: Double {
        return Double.random(in: 60 ... 512.0)
    }
    
}
