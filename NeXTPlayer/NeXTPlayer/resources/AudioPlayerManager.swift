//
//  AudioPlayerManager.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 15/10/23.
//

import AVFoundation
import Combine

class AudioPlayerManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    static let shared = AudioPlayerManager()
    var playbackFinishedPublisher = PassthroughSubject<Void, Never>()
    
    var audioPlayer: AVAudioPlayer?
    var timer: Timer?
    var startTime: Date?
    


    private override init() {
        super.init()
    }

    func playAudio(from url: URL) throws {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.play()
        } catch {
            throw error
        }
    }

    func stopAudio() {
        audioPlayer?.stop()
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            timer?.invalidate()
            playbackFinishedPublisher.send()
        }
    }
    


}

