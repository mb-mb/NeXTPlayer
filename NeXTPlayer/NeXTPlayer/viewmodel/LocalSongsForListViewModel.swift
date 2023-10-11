//
//  LocalSongsForListViewModel.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 06/10/23.
//
import AVFoundation
import Foundation
import MediaPlayer
import Combine
import MusicKit


class LocalSongsForAlbumListViewModel: NSObject, ObservableObject {
    
    @Published var songs = [LocalSong]()
    @Published var artists: [LocalArtist] = []
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
    @Published var timeLabel: String = "00:00"
    var cancellables = Set<AnyCancellable>()
    let service = APIService()
    var audioPlayer: AVAudioPlayer?
    var timer: Timer?
    var startTime: Date?
    var albumID: Int
    
    
    init(albumID: Int ) {
        self.albumID = albumID
        super.init()
        self.fetchSongs(albumID: albumID)
        print("LocalSongsForAlbumListViewModel - init songs for albumID \(albumID)")
    }
    
    
    
    lazy var songState: String = {
        switch playerState {
        case .stop:
            return PlayerState.stop.rawValue
        case .play:           
            return PlayerState.play.rawValue
        case .pause:
            return PlayerState.pause.rawValue
        case .error:
            return PlayerState.stop.rawValue
        }
    }()
    
    static func example() -> LocalSongsForAlbumListViewModel {
        let vm = LocalSongsForAlbumListViewModel(albumID: 0)
        print("mock songs for album \(1) has \(vm.songs.count) item")
        return vm
    }
    
    
    func fetchSongs(albumID: Int) {
        fetchLocalSongsForAlbumID(albumID: albumID)
            .sink ( receiveCompletion: { receive in
                switch receive {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error.description)
                }
            }, receiveValue: {[weak self] value in
                print("fetchSongs: \(value)")
                self?.songs = value
            }).store(in: &cancellables)
    }
    
}

extension LocalSongsForAlbumListViewModel {

    func songTimeLabel(for song: LocalSong) -> String? {
        if let _song = songs.first( where: { $0.id == song.id && $0.songState == .play}) {
            return timeLabel
        } else {
            return nil
        }
    }
    func songState(for song: LocalSong) -> String {
        for item in songs {
            if item.id == song.id {
                return item.songState.rawValue
            }
        }
        return PlayerState.stop.rawValue
    }
    
    func play(song: LocalSong) {
        var found = false
        for index in songs.indices {
            var _localSong = songs[index]
            if  _localSong.id == song.id {
                switch _localSong.songState {
                case .stop:
                    _localSong.songState = .play
                    startPlaybackMock()                    
                case .play:
                    _localSong.songState = .stop
                    stopPlayback()
                case .pause:
                    break
                case .error:
                    break
                }
                songs[index] = _localSong
                found = true
            } else {
                _localSong.songState = .stop
                timeLabel = "00:00"
                songs[index] = _localSong
            }
        }
        if !found {
            var localSong = song
            localSong.songState = .play
            startPlaybackMock()
            songs.append(localSong)
        }
                
                
//        switch song.songState {
//        case .stop:
//            do {
////                try playMedia(for: song)
//                playerState = PlayerState.play
//                songState = PlayerState.play.rawValue
//                if var localSong = songs.first( where: { $0.id == song.id }) {
//                    localSong.songState = .play
//                } else {
//                    var localSong = song
//                    localSong.songState = .play
//                    localSongs.append(localSong)
//                }
//            } catch {
//                print(error)
//                playerState = .error
//            }
//        case .play:
//            playerState = PlayerState.stop
//            songState = PlayerState.stop.rawValue
//            audioPlayer?.stop()
//            stopPlayback()
//            if var localSong = songs.first( where: { $0.id == song.id }) {
//                localSong.songState = .stop
//            } else {
//                var localSong = song
//                localSong.songState = .stop
//                localSongs.append(localSong)
//            }
//        case .pause:
//            playerState = PlayerState.stop
//            songState = PlayerState.stop.rawValue
//            for var item in songs {
//                if item.id == song.id {
//                    item.songState = .stop
//                }
//                localSongs.append(item)
//            }
//        case .error:
//            print("not playing at all")
//        }
    
//        songs = localSongs
    }
    
    func playMedia(for song: LocalSong) throws {
        //        if let mp3FilePath = Bundle.main.path(forResource: song.song.trackName, ofType: "mp3") {
        //        let mp3FileURL = URL(fileURLWithPath: song.song.trackViewURL)
        //            let mp3FileURL = URL(fileURLWithPath: song.song.trackViewURL)
        //        if let url = URL(string:  song.song.trackViewURL),
        //           let mp3FileURL = URL(string: url.absoluteString.replacing("Unknown%20", with: "") ?? "") {
//        if let mp3FileURL = Bundle.main.path(forResource: song.song.trackName, ofType: "mp3") {
        if let assetURL = song.trackURL {
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                audioPlayer = try AVAudioPlayer(contentsOf: assetURL)
                audioPlayer?.delegate = self
                audioPlayer?.play()
                playerState = PlayerState.play
                songState = PlayerState.play.rawValue
                startPlayback()
            } catch {
                print(error)
                print("Error playing the MP3 file: \(error.localizedDescription)")
            }
            
        }
    }
}

extension LocalSongsForAlbumListViewModel: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            timer?.invalidate()
        }
    }
    
    @objc func updatePlaybackTime() {
        if let currentTime = audioPlayer?.currentTime {
            // Handle the current playback time, e.g., update a label
            timeLabel = currentTime.formatTime()
        }
    }

    @objc func updatePlaybackTimeMock() {
        guard let _startTime = startTime else { return }

         let currentTime = Date().timeIntervalSince(_startTime)
         timeLabel = currentTime.formatTime()
    }

    
    func startPlayback() {
        audioPlayer?.play()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatePlaybackTimeMock), userInfo: nil, repeats: true)
    }

    func startPlaybackMock() {
        audioPlayer?.play()
        startTime = Date()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatePlaybackTimeMock), userInfo: nil, repeats: true)
    }

    
    func stopPlayback() {
        audioPlayer?.stop()
        timeLabel = "00:00"
        timer?.invalidate()
    }
    
}

class MPMediaItemToArtistMapper {
    static func map(mpMediaItem: MPMediaItem) -> LocalArtist {
        return LocalArtist(
            artist: mpMediaItem,
            artistState: .stop
        )
    }
}




class MPMediaItemToSongMapper {
    static func map(mpMediaItem: MPMediaItem) -> LocalSong {
        // iphone: "ipod-library://item/item.mp3?id=3501933151986661196"
        // mac:
        
        return LocalSong(song: mpMediaItem, songState: .stop)
    }
}

