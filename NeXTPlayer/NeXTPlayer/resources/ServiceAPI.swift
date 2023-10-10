//
//  ServiceAPI.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 09/10/23.
//

import Foundation
import Combine
import MediaPlayer

func fetchLocalSongs() -> AnyPublisher<[LocalSong], APIError> {
    return Future<[LocalSong], APIError> { promise in
        let query = MPMediaQuery.songs()
        
        guard let collections = query.collections else {
            promise(.failure(.fetchFailed))
            return
        }
        
        let localSongs = collections.compactMap { collection -> LocalSong? in
            guard let representativeItem = collection.representativeItem else {
                print("fetchLocalSongs2 compactMap: \(collection.count)")
                return nil
            }
            
            return MPMediaItemToSongMapper.map(mpMediaItem: representativeItem)
        }
        print("fetchLocalSongs2 receiveValue: \(localSongs.count)")
        promise(.success(localSongs))
    }
    .eraseToAnyPublisher()
}

func fetchLocalSongsForAlbumID(albumID: Int) -> AnyPublisher<[LocalSong], APIError> {
    return Future<[LocalSong], APIError> { promise in
        let query = MPMediaQuery.songs()

        guard let collections = query.collections else {
            promise(.failure(.fetchFailed))
            return
        }
        
        // Create a predicate to filter by album persistent ID
         let albumPredicate = MPMediaPropertyPredicate(
             value: NSNumber(value: albumID),
             forProperty: MPMediaItemPropertyAlbumPersistentID,
             comparisonType: .equalTo)
        
        query.addFilterPredicate(albumPredicate)
        
        let localSongs = collections.compactMap { collection -> LocalSong? in
            guard let representativeItem = collection.representativeItem else {
                print("fetchLocalSongsForAlbumID compactMap: \(collection.count)")
                return nil
            }
            
            return MPMediaItemToSongMapper.map(mpMediaItem: representativeItem)
        }
        print("fetchLocalSongsForAlbumID receiveValue: \(localSongs.count)")
        promise(.success(localSongs))
    }
    .eraseToAnyPublisher()

}
