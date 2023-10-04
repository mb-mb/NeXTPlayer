//
//  Movie.swift
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
struct MovieResult: Codable {
    let resultCount: Int
    let results: [Movie]
}

// MARK: - Movie
struct Movie: Codable, Identifiable {
    var id: Int?
    let wrapperType, kind: String
    let collectionId, trackID: Int?
    let artistName,  trackName : String
    let collectionCensoredName: String?
    let collectionName : String?
    let trackCensoredName: String
    let collectionArtistID: Int?
    let collectionArtistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let collectionPrice, trackPrice, collectionHDPrice: Double?
    let trackRentalPrice: Double?
    let trackHDPrice, trackHDRentalPrice: Double?
    let releaseDate: String?
    let collectionExplicitness, trackExplicitness: String
    let trackCount, trackNumber, trackTimeMillis: Int?
    let country, currency, primaryGenreName, contentAdvisoryRating: String
    let shortDescription, longDescription: String?
    let hasITunesExtras: Bool?
    let discCount, discNumber: Int?

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind, id
        case collectionId = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case collectionArtistID = "collectionArtistId"
        case collectionArtistViewURL = "collectionArtistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, trackRentalPrice
        case collectionHDPrice = "collectionHdPrice"
        case trackHDPrice = "trackHdPrice"
        case trackHDRentalPrice = "trackHdRentalPrice"
        case releaseDate, collectionExplicitness, trackExplicitness, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, contentAdvisoryRating, shortDescription, longDescription, hasITunesExtras, discCount, discNumber
    }
}

