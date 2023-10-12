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
    let id: UUID
    var album: Album
    var artwork: Data?
    
    enum CodingKeys: String, CodingKey {
        case album, id
    }
    
    
    init(album: MPMediaItem, artistState: PlayerState) {
        self.id = UUID()
        let _album = Album(wrapperType: "collection", collectionType: "Album",
                           id: Int(album.albumPersistentID),
                           artistID: UInt64(album.artistPersistentID),
                           amgArtistID: Int(album.composerPersistentID),
                           artistName: album.artist ?? "",
                           collectionName: album.title ?? "",
                           collectionCensoredName: "",
                           artistViewURL: "",
                           collectionViewURL: album.assetURL?.absoluteString ?? "",
                           artworkUrl60: album.assetURL?.absoluteString ?? "",
                           artworkUrl100: album.assetURL?.absoluteString ?? "",
                           collectionPrice: 0,
                           collectionExplicitness: "",
                           trackCount: album.albumTrackCount,
                           copyright: "", country: "", currency: "",
                           releaseDate: album.releaseDate?.formatted(date: .long, time: .complete) ?? "",
                           primaryGenreName: album.genre ?? "")
        if let artWork = album.artwork,
            let data = artWork.image(at: CGSize(width: 100, height: 100))?.pngData() {
            self.artwork = data
        } else {
            self.artwork = nil
        }
        self.album = _album
        
    }
    
    static func mockData() -> [LocalAlbum] {
        let album0 = LocalAlbum(album: MockMediaItem(), artistState: .stop)
        let album1 = LocalAlbum(album: MockMediaItem(), artistState: .stop)
        let album2 = LocalAlbum(album: MockMediaItem(), artistState: .stop)
        let album3 = LocalAlbum(album: MockMediaItem(), artistState: .stop)
        let album4 = LocalAlbum(album: MockMediaItem(), artistState: .stop)
        let album5 = LocalAlbum(album: MockMediaItem(), artistState: .stop)
        let album6 = LocalAlbum(album: MockMediaItem(), artistState: .stop)
        let album7 = LocalAlbum(album: MockMediaItem(), artistState: .stop)
        let album8 = LocalAlbum(album: MockMediaItem(), artistState: .stop)
        return [album0, album1, album2, album3, album4, album5, album6, album7, album8]
    }
}
