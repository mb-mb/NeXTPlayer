//
//  State.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 03/10/23.
//

import Foundation

enum FetchState: Comparable {
    case good
    case isLoading
    case loadedAll
    case error(String)
}

enum PlayerState: String, Decodable {
    case stop = "play.rectangle"
    case play = "music.quarternote.3"
    case pause = "pause.rectangle"
    case error = "error.playing"
}
