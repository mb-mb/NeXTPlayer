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
    var playBack = AudioPlayerManager.shared.playbackFinishedPublisher
    
    
    init(albumID: UInt64) {
        super.init()
        self.fetchSongs(albumID: albumID)
        
        playBack
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                // Handle the audio playback completion event here
                print("Audio playback finished")
                self?.playNextSong()
            }
            .store(in: &cancellables)
        
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
        let vm = LocalSongsForAlbumListViewModel(albumID: UInt64(0))
        vm.songs = LocalSong.mock()
        print("mock songs for album \(1) has \(vm.songs.count) item")
        return vm
    }
    
    
    func fetchSongs(albumID: UInt64) {
        fetchLocalSongsForAlbumID(albumID: albumID)
            .sink ( receiveCompletion: { receive in
                switch receive {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error.description)
                }
            }, receiveValue: {[weak self] value in
                self?.songs = value
            }).store(in: &cancellables)
    }
    
}

extension LocalSongsForAlbumListViewModel {

    func songTimeLabel(for song: LocalSong) -> String? {
        if let _ = songs.first( where: { $0.id == song.id && $0.songState == .play}) {
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
//                    startPlayback()
                    do {
                        try playMedia(for: _localSong)
                    } catch {
                        // change state of message error
                        print(error)
                    }
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
            playerState = .play
            startPlayback()
            songs.append(localSong)
        }
    }
    
    func playMedia(for song: LocalSong) throws {
        if let assetURL = song.trackURL {
            do {
                try AudioPlayerManager.shared.playAudio(from: assetURL)
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

extension LocalSongsForAlbumListViewModel {
    
    func playNextSong() {
        if let currentlyPlayingIndex = songs.firstIndex(where: { $0.songState == .play }) {
            songs[currentlyPlayingIndex].songState = .stop
            stopPlayback()
            let nextIndex = currentlyPlayingIndex + 1

            if nextIndex < songs.count {
                play(song: songs[nextIndex])
            }
        }
    }
    
    
    func stopPlayback() {
        AudioPlayerManager.shared.stopAudio()
        timeLabel = "00:00"
        AudioPlayerManager.shared.timer?.invalidate()
    }
    
    @objc func updatePlaybackTime() {
        if let currentTime = AudioPlayerManager.shared.audioPlayer?.currentTime {
            // Handle the current playback time, e.g., update a label
            timeLabel = currentTime.formatTime()
        }
    }
    
    func startPlayback() {
        AudioPlayerManager.shared.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatePlaybackTime), userInfo: nil, repeats: true)
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

