//
//  Album.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 03/10/23.
//
//  This file was generated from JSON Schema using quicktype, do not modify it directly.
//  To parse the JSON, add this file to your project and do:
//
//  let albumResult = try? JSONDecoder().decode(AlbumResult.self, from: jsonData)


import Foundation

// MARK: - AlbumResult
struct AlbumResult: Codable {
    let resultCount: Int
    let results: [Album]
}

// MARK: - Album
struct Album: Codable, Identifiable {
    var id: UUID?
    let wrapperType, collectionType: String
    let artistID: Int?
    let amgArtistId: Int?
    let artistName, collectionName, collectionCensoredName: String
    let artistViewURL, collectionViewURL: String?
    let artworkUrl60, artworkUrl100: String
    let collectionPrice: Double?
    let collectionExplicitness: String
    let trackCount: Int
    let copyright, country, currency: String
    let releaseDate: String?
    let primaryGenreName: String

    enum CodingKeys: String, CodingKey {
        case id
        case wrapperType, collectionType
        case artistID
        case amgArtistId 
        case artistName, collectionName, collectionCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case artworkUrl60, artworkUrl100, collectionPrice, collectionExplicitness, trackCount, copyright, country, currency, releaseDate, primaryGenreName
    }
    
    static func mock() -> [Album] {
        let album: [Album] = [
            Album(id: UUID(), wrapperType: "collection", collectionType: "Album", artistID: 123456, amgArtistId: 12345678, artistName: "Taylor Swift", collectionName: "Red", collectionCensoredName: "Red", artistViewURL: "https://music.apple.com/us/artist/taylor-swift/159260351?uo=4", collectionViewURL: "https://music.apple.com/us/album/red/1442886632?uo=4", artworkUrl60: "https://is1-ssl.mzstatic.com/image/thumb/Music118/v4/59/21/75/59217599-1719-e956-6b46-7b72509f319a/886446650479.jpg/60x60bb.jpg", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music118/v4/59/21/75/59217599-1719-e956-6b46-7b72509f319a/886446650479.jpg/100x100bb.jpg", collectionPrice: 9.99, collectionExplicitness: "notExplicit", trackCount: 16, copyright: "℗ 2012 Big Machine Records, LLC", country: "USA", currency: "USD", releaseDate: "2012-10-22", primaryGenreName: "Pop")
            ]
        return album
    }
}
