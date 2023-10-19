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

func fetchLocalSongsForAlbumID(albumID: UInt64) -> AnyPublisher<[LocalSong], APIError> {
    return Future<[LocalSong], APIError> { promise in
        let query = MPMediaQuery.songs()
        // Create a predicate to filter by album persistent ID
         let albumPredicate = MPMediaPropertyPredicate(
             value: NSNumber(value: albumID),
             forProperty: MPMediaItemPropertyAlbumPersistentID,
             comparisonType: .equalTo)
        
        query.addFilterPredicate(albumPredicate)

        
        guard let collections = query.collections else {
            promise(.failure(.fetchFailed))
            return
        }
        
        var localSongs = collections.compactMap { collection -> LocalSong? in
            guard let representativeItem = collection.representativeItem else {
                print("fetchLocalSongsForAlbumID compactMap: \(collection.count)")
                return nil
            }
            
            return MPMediaItemToSongMapper.map(mpMediaItem: representativeItem)
        }
        print("fetchLocalSongsForAlbumID receiveValue: \(localSongs.count)")
        localSongs.sort{ $0.trackNumber < $1.trackNumber }
        promise(.success(localSongs))
    }
    .eraseToAnyPublisher()

}


func makeFakeImage(index: Int) -> UIImage {
    // Load the image from the asset catalog
    //    let image = UIImage(named: "metal_band")
    
    let imageName = ["metal_band",
                     "jazz_band",
                     "robot_band"]
    
    if let img =  UIImage(named: imageName[index]) {
        return img
    }
    
    return  UIImage(systemName: "music.mic.circle")!
    
}


func makeFakeImageAlbum(index: Int) -> String {
    // Load the image from the asset catalog
//    let image = UIImage(named: "metal_band")
    
    let imageName = ["metal_band",
                     "jazz_band",
                     "robot_band"]
   
    let imageData = UIImage(named: imageName[index])
    
    
    if let imageData = imageData?.pngData() {
        // Get the app's documents directory
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            // Construct a unique file name (e.g., using a timestamp or other identifier)
            
            let uniqueFileName = "\(imageName[index]).png"
            
            // Append the file name to the documents directory URL to get the URL of the saved image
            let fileURL = documentsDirectory.appendingPathComponent(uniqueFileName)
            
            do {
                // Write the image data to the file
                try imageData.write(to: fileURL)
                
                // Now, you can use 'fileURL' to reference the image as a URL.
                return fileURL.absoluteString
            } catch {
                print("Error saving image: \(error)")
            }
        }
    }
    return ""
}
