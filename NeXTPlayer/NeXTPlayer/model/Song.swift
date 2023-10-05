//
//  Song.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 03/10/23.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let albumResult = try? JSONDecoder().decode(AlbumResult.self, from: jsonData)

import Foundation

// MARK: - AlbumResult
struct SongResult: Codable {
    let resultCount: Int
    let results: [Song]

//    enum CodingKeys: String, CodingKey {
//        case resultCount
//        case songs = "Songs"
//    }
}

// MARK: - Song
struct Song: Codable {
    let wrapperType: WrapperType
    let kind: Kind
    let artistID, collectionID, trackID: Int
    let artistName, collectionName, trackName, collectionCensoredName: String
    let trackCensoredName: String
    let artistViewURL, collectionViewURL, trackViewURL: String
    let previewURL: String
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let collectionPrice, trackPrice: Double?
    let releaseDate: String?
    let collectionExplicitness: String?
    let trackExplicitness: String? //Explicitness
    let discCount, discNumber, trackCount, trackNumber: Int
    let trackTimeMillis: Int
    let country: String?
    let currency: String?
    let primaryGenreName: String? //PrimaryGenreName?
    let isStreamable: Bool
    let contentAdvisoryRating: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable, contentAdvisoryRating
    }
    
    static func mockData() ->[Song] {
        return  [Song(wrapperType: .track, kind: .song, artistID: 123456789, collectionID: 987654321, trackID: 1234567890, artistName: "Taylor Swift", collectionName: "1989", trackName: "Shake It Off", collectionCensoredName: "1989 (Clean)", trackCensoredName: "Shake It Off (Clean)", artistViewURL: "https://itunes.apple.com/us/artist/taylor-swift/id123456789", collectionViewURL: "https://itunes.apple.com/us/album/shake-it-off/id987654321", trackViewURL: "https://itunes.apple.com/us/song/shake-it-off/id1234567890", previewURL: "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/AudioPreview11/v4/38/56/b4/3856b42d-6b83-e43c-4b9d-a50121582e89/mzaf_594406400176088865.aac.m4a", artworkUrl30: "https://is1-ssl.mzstatic.com/image/thumb/Music/e4/c2/ce/mzi.txpkjoey.jpg/30x30bb.jpg", artworkUrl60: "https://is1-ssl.mzstatic.com/image/thumb/Features115/v4/db/4b/0b/db4b0be4-02d9-c8ee-3ade-f44a6cdf5ae2/dj.eeqcsgup.jpg/60x60bb.jpg", artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/1d/28/c1/1d28c112-e991-4944-a80c-f3695e9322b0/source/100x100bb.jpg", collectionPrice: 12.99, trackPrice: 1.29, releaseDate: "2014-10-27T00:00:00Z", collectionExplicitness: "explicit", trackExplicitness: "explicit", discCount: 1, discNumber: 1, trackCount: 13, trackNumber: 1, trackTimeMillis: 205124, country: "US", currency: "USD", primaryGenreName: "Pop", isStreamable: true, contentAdvisoryRating: "Explicit"),
                 Song(wrapperType: .track, kind: .song, artistID: 123456789, collectionID: 987654321, trackID: 1234567890, artistName: "Taylor Swift 2", collectionName: "1989", trackName: "Shake It Off 2", collectionCensoredName: "1989 (Clean)", trackCensoredName: "Shake It Off (Clean)", artistViewURL: "https://itunes.apple.com/us/artist/taylor-swift/id123456789", collectionViewURL: "https://itunes.apple.com/us/album/shake-it-off/id987654321", trackViewURL: "https://itunes.apple.com/us/song/shake-it-off/id1234567890", previewURL: "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/AudioPreview11/v4/38/56/b4/3856b42d-6b83-e43c-4b9d-a50121582e89/mzaf_594406400176088865.aac.m4a", artworkUrl30: "https://is1-ssl.mzstatic.com/image/thumb/Music/e4/c2/ce/mzi.txpkjoey.jpg/30x30bb.jpg", artworkUrl60: "https://is1-ssl.mzstatic.com/image/thumb/Features115/v4/db/4b/0b/db4b0be4-02d9-c8ee-3ade-f44a6cdf5ae2/dj.eeqcsgup.jpg/60x60bb.jpg", artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/1d/28/c1/1d28c112-e991-4944-a80c-f3695e9322b0/source/100x100bb.jpg", collectionPrice: 12.99, trackPrice: 1.29, releaseDate: "2014-10-27T00:00:00Z", collectionExplicitness: "explicit", trackExplicitness: "explicit", discCount: 1, discNumber: 1, trackCount: 13, trackNumber: 1, trackTimeMillis: 205124, country: "US", currency: "USD", primaryGenreName: "Pop", isStreamable: true, contentAdvisoryRating: "Explicit")
        ]
    }
                 
}

enum Explicitness: String, Codable {
    case explicit = "explicit"
    case notExplicit = "notExplicit"
}

enum Country: String, Codable {
    case usa = "USA"
}

enum Currency: String, Codable {
    case usd = "USD"
}

enum Kind: String, Codable {
    case song = "song"
}

enum PrimaryGenreName: String, Codable {
    case dance = "Dance"
    case pop = "Pop"
    case rock = "Rock"
    case soundtrack = "Soundtrack"
}

enum WrapperType: String, Codable {
    case track = "track"
}


