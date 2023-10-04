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
}
