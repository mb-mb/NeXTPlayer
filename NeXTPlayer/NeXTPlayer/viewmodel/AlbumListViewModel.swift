//
//  AlbumListViewModel.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 03/10/23.
//

import Foundation
import SwiftUI
import Combine

class AlbumListViewModel: ObservableObject {

    enum State: Comparable {
        case good
        case isLoading
        case loadedAll
        case error(String)
    }
    
    @Published var searchTerm: String = ""
    @Published var albums: [Album] = [Album]()
    @Published var state: State = .good {
        didSet {
            print("state changed to : \(state)")
        }
    }
    
    var subscription = Set<AnyCancellable>()
    let limit: Int = 20
    var page: Int = 1
    
    
    init() {
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.state = .good
                self?.page = 0
                self?.albums = []
                self?.fetchAlbum(for: term)
            }.store(in: &subscription)
    }
    
    func loadMore() {
        fetchAlbum(for: searchTerm)
    }
    
    func fetchAlbum(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == .good else {
            return
        }
        
        
        guard let url = createURL(for: searchTerm) else {
            return
        }
        
        print(url)
        
        state = .isLoading
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            if let error = error {
                print ("error: \(error)")
                DispatchQueue.main.async {
                    self?.state = .error("could not load: \(error.localizedDescription)")
                }
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(AlbumResult.self, from: data)
                    DispatchQueue.main.async {
                        for album in result.results {
                            self?.albums.append(album)
                        }
                        self?.page += 1
                        self?.state = (result.results.count == self?.limit) ? .good : .loadedAll
                    }
                    

                } catch {
                    print("decoding error:  \(error)")
                    DispatchQueue.main.async {
                        self?.state = .error("could get data: \(error.localizedDescription)")
                    }
                }
            }

            
        }.resume()
    }
    
    
    func createURL(for searchItem: String) -> URL? {
        
        let baseURL = urlAlbums
        let offset = page * limit
        let queryItems = [
            URLQueryItem(name: "term", value: searchItem),
            URLQueryItem(name: "entity", value: "album"),
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(offset))
        ]
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url
        
    }
}
