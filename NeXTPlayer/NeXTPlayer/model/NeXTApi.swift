//
//  NeXTApi.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 18/10/21.
//

import Foundation
import Combine
import CoreData

final class NeXTApi {
    
    static let shared = NeXTApi()
    
    private init() {}
    
    func fetchArtists(name: String? = "") -> Future<[Artist], Error> {
        return Future { promisse in
            promisse(.success(Artist.data()))
        }
    }


    func fetchAlbums(from: String) -> Future<[Albums], Error> {
        return Future { promisse in
            
            var albums: [Albums] = []
            
            _ = Artist.data().map { artist in
                if artist.name == from {
                    albums.append(contentsOf: artist.albums)
                }
            }
            
            promisse(.success(albums))
        }
    }

}
