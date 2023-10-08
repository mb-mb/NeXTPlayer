//
//  LocalSongsForListViewModel.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 06/10/23.
//

import Foundation
import MediaPlayer
import Combine
import MusicKit

class LocalSongsForAlbumListViewModel: ObservableObject {
    
    @Published var songs = [LocalSong]()
    @Published var artists: [MPMediaItem] = []
    @Published var state: FetchState = .good {
        didSet {
            print("state changed to : \(state)")
        }
    }
    @Published var playerState: PlayerState = .stop {
        didSet {
            print("playerState changed to : \(playerState)")
        }
    }
    @Published var playStateDescription: String = PlayerState.stop.rawValue
    var cancellables = Set<AnyCancellable>()
    let service = APIService()
    let albumID: Int
    
    init(albumID: Int = 0) {
        self.albumID = albumID
        print("LocalSongsForAlbumListViewModel - init for songs for album \(albumID)")
    }
    
    
    func fetch() {
        fetchLocalSongs(for: albumID)
    }
    
    lazy var songState: String = {
        switch playerState {
        case .stop:
            return PlayerState.stop.rawValue
        case .play:           
            return PlayerState.play.rawValue
        case .pause:
            return PlayerState.pause.rawValue
        }
    }()
    
    static func example() -> LocalSongsForAlbumListViewModel {
        let vm = LocalSongsForAlbumListViewModel(albumID: 1)
        vm.songs = [LocalSong.example(), LocalSong.example()]
        print("mock songs for album \(1) has \(vm.songs.count) item")
        return vm
    }
    
    
    

    func fetchLocalSongs(for albumID: Int) {
//        let query = MPMediaQuery.songs()
//        query
//            .publisher
//            .sink {[weak self]  mediaItem in
//                _ = mediaItem.map { item in
//                    let song = Song(wrapperType: "Song",
//                                    artistID: Int(item),
//                                    collectionID: Int(item.composerPersistentID), id: Int(item.persistentID),
//                                    artistName: item.artist ?? "",
//                                    collectionName: item.albumTitle ?? "",
//                                    trackName: "Upside Down", artistViewURL: "", collectionViewURL: "",
//                                    trackViewURL: item.assetURL?.absoluteString ?? "",
//                                    previewURL: "https://is3-ssl.mzstatic.com",
//                                    artworkUrl30: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/30x30bb.jpg", artworkUrl60: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/60x60bb.jpg", artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/100x100bb.jpg", collectionPrice: 9.88, trackPrice: 1.29, releaseDate: "2005-01-01T12:00:00Z", trackCount: 14, trackNumber: 1, trackTimeMillis: 208643, country: "USA", currency: "USD", primaryGenreName: "Rock", collectionArtistName: nil)
//                    let localSong = LocalSong(song: song, songState: PlayerState.stop)
//                    self?.songs.append(localSong)
//                }
//                self?.state =  .good
//                print("fetched \(mediaItem.description) songs for albumID: \(albumID)")
//            }.store(in: &cancellables)
    }
}

extension LocalSongsForAlbumListViewModel {
    func play( song: LocalSong) {
        var localSongs: [LocalSong]=[]
        switch playerState {
        case .stop:
            playerState = PlayerState.play
            songState = PlayerState.play.rawValue
            
            for var item in songs {
                if item.id == song.id {
                    item.songState = .play
                }
                localSongs.append(item)
            }
            
        case .play:
            playerState = PlayerState.stop
            songState = PlayerState.stop.rawValue
            for var item in songs {
                if item.id == song.id {
                    item.songState = .stop
                }
                localSongs.append(item)
            }
        case .pause:
            playerState = PlayerState.stop
            songState = PlayerState.stop.rawValue
            for var item in songs {
                if item.id == song.id {
                    item.songState = .stop
                }
                localSongs.append(item)
            }
        }
        songs = localSongs
    }
}

class MPMediaItemToArtistMapper {
    static func map(mpMediaItem: MPMediaItem) -> LocalArtist {
        return LocalArtist(
            id: mpMediaItem.persistentID,
            name: mpMediaItem.artist,
            genre: mpMediaItem.genre,
            artworkUrl100: mpMediaItem.artwork?.description
        )
    }
}

struct LocalArtist: Identifiable {
    let id: UInt64
    let name: String?
    let genre: String?
    let artworkUrl100: String?
}


class MPMediaItemToSongMapper {
    static func map(mpMediaItem: MPMediaItem) -> LocalSong2 {
        return LocalSong2(
            id: mpMediaItem.persistentID,
            name: mpMediaItem.artist,
            genre: mpMediaItem.genre,
            title: mpMediaItem.title,
            artworkUrl100: mpMediaItem.artwork?.description
        )
    }
}

struct LocalSong2 {
    let id: UInt64
    let name: String?
    let genre: String?
    let title: String?
    let artworkUrl100: String?
}
