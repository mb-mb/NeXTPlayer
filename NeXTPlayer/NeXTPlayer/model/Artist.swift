//
//  PixabayItem.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 12/10/21.
//

import Foundation

struct Artist: Decodable {
    let id: Int
    let name: String
    let albums: [Albums]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name = "john doe"
        case albums
    }
}



extension Artist: Identifiable { }

struct Albums: Decodable {
    let id: Int
    let artist: [Artist]
    let albumImage: URL?
    let albumName: String
    let date: Date
    let songs: [Songs]

    private enum CodingKeys: String, CodingKey {
        case id
        case artist
        case albumImage
        case albumName
        case date
        case songs
    }

}

extension Albums: Identifiable { }

extension Artist {
    static let url = URL(string: "https://www.zappa.com/sites/g/files/aaj776/f/styles/suzuki_breakpoints_image_tablet/public/release/201601/04_WOIIFTM_cover.jpg")

    static func artistAlbumData() -> [Albums] {
        let artist5 = [Artist(id: 1, name: "Rush", albums: [])]
        let songs = [Songs(id: 0, name: "We're only in it for the money", albumPosition: 1, duration: 3.54),
                     Songs(id: 1, name: "track 02", albumPosition: 2, duration: 3.54),
                     Songs(id: 2, name: "track 3", albumPosition: 3, duration: 3.54)]



        return [Albums(id: 0, artist: artist5, albumImage: url, albumName: "Bastile Day", date: Date(), songs: songs),
                Albums(id: 0, artist: artist5, albumImage: url, albumName: "Bastile Day", date: Date(), songs: songs),
                Albums(id: 0, artist: artist5, albumImage: url, albumName: "Bastile Day", date: Date(), songs: songs)]
    }
    
    static func data()-> [Artist] {
        let songs = [Songs(id: 0, name: "We're only in it for the money", albumPosition: 1, duration: 3.54),
                     Songs(id: 1, name: "track 02", albumPosition: 2, duration: 3.54),
                     Songs(id: 2, name: "track 3", albumPosition: 3, duration: 3.54)]
        
        let artist = [Artist(id: 0, name: "Frank Zappa", albums: [])]
        let data = [ Albums(id: 0, artist: artist, albumImage: url, albumName: "Mothers of Invention", date: Date(), songs: songs),
                     Albums(id: 1, artist: artist, albumImage: url, albumName: "Zoo Out", date: Date(), songs: songs),
                     Albums(id: 2, artist: artist, albumImage: url, albumName: "Shutup and play your guitar", date: Date(), songs: songs)]

        let artist2 = [Artist(id: 1, name: "King Crimson", albums: [])]
        let data2 = [ Albums(id: 0, artist: artist2, albumImage: url, albumName: "Mothers of Invention", date: Date(), songs: songs),
                      Albums(id: 1, artist: artist2, albumImage: url, albumName: "Zoo Out", date: Date(), songs: songs),
                      Albums(id: 2, artist: artist2, albumImage: url, albumName: "Shutup and play your guitar", date: Date(), songs: songs)]

        
        let artist3 = [Artist(id: 0, name: "Dream Theater", albums: [])]
        let data3 = [ Albums(id: 0, artist: artist3, albumImage: url, albumName: "6 Degress of inner turbulence", date: Date(), songs: songs),
                      Albums(id: 1, artist: artist3, albumImage: url, albumName: "Zoo Out", date: Date(), songs: songs),
                      Albums(id: 2, artist: artist3, albumImage: url, albumName: "Shutup and play your guitar", date: Date(), songs: songs)]

        let artist4 = [Artist(id: 1, name: "Symphony X", albums: [])]
        let data4 = [ Albums(id: 0, artist: artist4, albumImage: url, albumName: "Medusa eyes", date: Date(), songs: songs),
                      Albums(id: 1, artist: artist4, albumImage: url, albumName: "Zoo Out", date: Date(), songs: songs),
                      Albums(id: 2, artist: artist4, albumImage: url, albumName: "Shutup and play your guitar", date: Date(), songs: songs)]


        let artist5 = [Artist(id: 1, name: "Rush", albums: [])]
        let data5 = [ Albums(id: 0, artist: artist5, albumImage: url, albumName: "Bastile Day", date: Date(), songs: songs),
                      Albums(id: 1, artist: artist5, albumImage: url, albumName: "Zoo Out", date: Date(), songs: songs),
                      Albums(id: 2, artist: artist5, albumImage: url, albumName: "Shutup and play your guitar", date: Date(), songs: songs)]

        let artists = [Artist(id: 0, name: "Frank Zappa",   albums: data),
                       Artist(id: 1, name: "King Crimson",  albums: data2),
                       Artist(id: 2, name: "Dream Theater", albums: data3),
                       Artist(id: 3, name: "Symphony X",    albums: data4),
                       Artist(id: 4, name: "Rush",          albums: data5)]

        return artists
    }
}

struct Songs: Decodable {
    let id: Int
    let name: String
    let albumPosition: Int
    let duration: Float
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case albumPosition
        case duration
    }
}

extension Songs: Identifiable { }
