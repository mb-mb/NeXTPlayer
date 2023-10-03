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
        
        let urlToSearch = urlAlbums
                            .replacingOccurrences(of: "[searchTerm]", with: searchTerm)
                            .replacingOccurrences(of: "[limit]", with: "\(limit)")
                            .replacingOccurrences(of: "[offset]", with: "\(page*limit)")
        
        guard let url = URL(string: urlToSearch) else {
            return
        }
        
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
}
