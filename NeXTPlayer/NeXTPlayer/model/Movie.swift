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
    
    static func mocl() -> [Movie] {
        let movies: [Movie] = [
            Movie(id: 0, wrapperType: "collection", kind: "Album", collectionId: 1251272998, trackID: nil, artistName: "8-Bit Arcade", trackName: "The Ultimate Tool", collectionCensoredName: "The Ultimate Tool", collectionName: nil, trackCensoredName: "The Ultimate Tool", collectionArtistID: nil, collectionArtistViewURL: "https://music.apple.com/us/artist/8-bit-arcade/608074618?uo=4", collectionViewURL: "https://music.apple.com/us/album/the-ultimate-tool/1251272998?uo=4", trackViewURL: nil, previewURL: nil, artworkUrl30: "https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/17/95/5a/17955a23-24f3-5f95-8eac-4c99996c4f2e/8BIT0122.jpg/60x60bb.jpg", artworkUrl60: "https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/17/95/5a/17955a23-24f3-5f95-8eac-4c99996c4f2e/8BIT0122.jpg/100x100bb.jpg", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/07/fd/e8/07fde8db-7b4d-1779-6e2d-82c96332a6f6/887158483523_Cover.jpg/100x100bb.jpg", collectionPrice: 10.99, trackPrice: 1.99, collectionHDPrice: 34, trackRentalPrice: 1.99, trackHDPrice: 1.99, trackHDRentalPrice: 1.00, releaseDate: "Jun-09-1999",
                  collectionExplicitness: "1.99", trackExplicitness: "1.99", trackCount: 1, trackNumber: 1,
                  trackTimeMillis: 1, country: "1.99", currency:"1.99", primaryGenreName: "Action", contentAdvisoryRating: "1", shortDescription: "short description", longDescription: "long description", hasITunesExtras: false, discCount: 1, discNumber: 1)]
        
        
        return movies
        
    }
}

