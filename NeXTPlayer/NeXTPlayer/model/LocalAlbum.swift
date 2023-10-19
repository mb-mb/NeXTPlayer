//
//  LocalAlbum.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 09/10/23.
//

import Foundation
import MusicKit
import MediaPlayer



struct LocalAlbumResult: Codable {
    let resultCount: Int
    let results: [LocalAlbum]
}

struct LocalAlbum: Codable, Identifiable {
    let id: UInt64
//    var album: Album
    var collectionName: String
    var artistID: UInt64
    var artwork: Data
    var releaseDate: String
    var artistName: String?
    var primaryGenreName: String
    var trackCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
//        case album
        case artistName
        case collectionName
        case artistID
        case artwork
        case releaseDate
        case primaryGenreName
        case trackCount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UInt64.self, forKey: .id)
//        self.album = try container.decode(Album.self, forKey: .album)
        self.artistName = try container.decode(String.self, forKey: .artistName)
        self.artistID = try container.decode(UInt64.self, forKey: .artistID)
        self.artwork = try container.decode(Data.self, forKey: .artwork)
        self.collectionName = try container.decode(String.self, forKey: .collectionName)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.primaryGenreName = try container.decode(String.self, forKey: .primaryGenreName)
        self.trackCount = try container.decode(Int.self, forKey: .trackCount)
    }
    
    
    init(album: MPMediaItem, artistState: PlayerState) {
        self.id = UInt64(album.albumPersistentID)
        self.artistID = UInt64(album.artistPersistentID)
        self.artistName = album.artist ?? ""
        self.releaseDate = album.releaseDate?.formatted(date: .long, time: .complete) ?? ""
        self.collectionName = album.title ?? ""
        self.primaryGenreName = album.genre ?? ""
        self.trackCount = album.albumTrackCount
//        let _album = Album(wrapperType: "collection", collectionType: "Album",
//                           id: 0,
//                           artistID: UInt64(album.artistPersistentID),
//                           amgArtistID: Int(album.composerPersistentID),
//                           artistName: album.artist ?? "",
//                           collectionName: album.title ?? "",
//                           collectionCensoredName: "",
//                           artistViewURL: "",
//                           collectionViewURL: album.assetURL?.absoluteString ?? "",
//                           artworkUrl60: album.assetURL?.absoluteString ?? "",
//                           artworkUrl100: album.assetURL?.absoluteString ?? "",
//                           collectionPrice: 0,
//                           collectionExplicitness: "",
//                           trackCount: album.albumTrackCount,
//                           copyright: "", country: "", currency: "",
//                           releaseDate: album.releaseDate?.formatted(date: .long, time: .complete) ?? "",
//                           primaryGenreName: album.genre ?? "")
        if let artWork = album.artwork,
            let data = artWork.image(at: CGSize(width: 100, height: 100))?.pngData() {
            self.artwork = data
        } else {
            let im = UIImage(systemName: "music.note.tv.fill")!
            self.artwork = im.pngData()!
        }
//        self.album = _album
        
    }
    
    static func mockData() -> [LocalAlbum] {
        
        let mockMPMediaItem = MockMediaItem()
        mockMPMediaItem.mockArtist = "Artist Name 1"
        mockMPMediaItem.mockGenre = "Pop"
        mockMPMediaItem.mockCollectionName = "Album Title 1"
        mockMPMediaItem.mockArtwork = MPMediaItemArtwork(boundsSize: CGSize(width: 100, height: 100), requestHandler: { size in
            return  makeFakeImage(index: 0)
        })

        
        let album0 = LocalAlbum(album: mockMPMediaItem, artistState: .stop)
        mockMPMediaItem.mockCollectionName = "album Title 2"
        mockMPMediaItem.mockArtist = "Artist Name 2"
        mockMPMediaItem.mockArtwork = MPMediaItemArtwork(boundsSize: CGSize(width: 100, height: 100), requestHandler: { size in
            return  makeFakeImage(index: 1)
        })

        let album1 = LocalAlbum(album: mockMPMediaItem, artistState: .stop)
        mockMPMediaItem.mockCollectionName = "Album Title 3"
        mockMPMediaItem.mockArtist = "Artist 3"

        mockMPMediaItem.mockArtwork = MPMediaItemArtwork(boundsSize: CGSize(width: 100, height: 100), requestHandler: { size in
            return  makeFakeImage(index: 2)
        })

        let album2 = LocalAlbum(album: mockMPMediaItem, artistState: .stop)
        mockMPMediaItem.mockCollectionName = "Album Title 4"
        mockMPMediaItem.mockArtist = "Artist Name 4"

        mockMPMediaItem.mockArtwork = MPMediaItemArtwork(boundsSize: CGSize(width: 100, height: 100), requestHandler: { size in
            return  makeFakeImage(index: 0)
        })

        let album3 = LocalAlbum(album: mockMPMediaItem, artistState: .stop)
        mockMPMediaItem.mockCollectionName = "Album Title 5"
        mockMPMediaItem.mockArtist = "Artist Name 5"

        mockMPMediaItem.mockArtwork = MPMediaItemArtwork(boundsSize: CGSize(width: 100, height: 100), requestHandler: { size in
            return  makeFakeImage(index: 1)
        })

        let album4 = LocalAlbum(album: mockMPMediaItem, artistState: .stop)
        mockMPMediaItem.mockCollectionName = "Album Title 6"
        mockMPMediaItem.mockArtist = "Artist Name 6"

        mockMPMediaItem.mockArtwork = MPMediaItemArtwork(boundsSize: CGSize(width: 100, height: 100), requestHandler: { size in
            return  makeFakeImage(index: 2)
        })

        let album5 = LocalAlbum(album: mockMPMediaItem, artistState: .stop)
        mockMPMediaItem.mockCollectionName = "Album Title 7"
        mockMPMediaItem.mockArtist = "Artist Name 7"

        mockMPMediaItem.mockArtwork = MPMediaItemArtwork(boundsSize: CGSize(width: 100, height: 100), requestHandler: { size in
            return  makeFakeImage(index: 0)
        })

        let album6 = LocalAlbum(album: mockMPMediaItem, artistState: .stop)
        mockMPMediaItem.mockCollectionName = "Album Title 8"
        mockMPMediaItem.mockArtist = "Artist Name 8"

        mockMPMediaItem.mockArtwork = MPMediaItemArtwork(boundsSize: CGSize(width: 100, height: 100), requestHandler: { size in
            return  makeFakeImage(index: 1)
        })

        let album7 = LocalAlbum(album: mockMPMediaItem, artistState: .stop)
        mockMPMediaItem.mockCollectionName = "Album Title 9"
        mockMPMediaItem.mockArtist = "Artist Name 9"

        mockMPMediaItem.mockArtwork = MPMediaItemArtwork(boundsSize: CGSize(width: 100, height: 100), requestHandler: { size in
            return  makeFakeImage(index: 2)
        })

        let album8 = LocalAlbum(album: mockMPMediaItem, artistState: .stop)
        let ret =  [album0, album1, album2, album3, album4, album5, album6, album7, album8]
        _ = ret.map { album in
            print("mock album -> \(album)")
        }
        
        return ret
    }
}
