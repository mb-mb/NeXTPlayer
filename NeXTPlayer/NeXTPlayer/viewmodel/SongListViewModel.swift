//
//  SongListViewModel.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 03/10/23.
//

import Foundation
import Combine

class SongsListViewModel: ObservableObject {
    let service = APIService()
    @Published var searchTerm: String = ""
    @Published var songs: [Song] = [Song]()
    @Published var state: FetchState = .good {
        didSet {
            print("state changed to : \(state)")
        }
    }
    
    var subscription = Set<AnyCancellable>()
    let limit: Int = 20
    var page: Int = 0
    
    init() {
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.state = .good
                self?.page = 0
                self?.songs = []
                self?.fetchSong(for: term)
            }.store(in: &subscription)
    }
    
    
    func fetchSong(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == .good else {
            return
        }
        
        state = .isLoading
        
        service.fetchSongs(searchTerm: searchTerm,  page: page, limit: limit ) {[weak self] results in
            
            DispatchQueue.main.async {
                switch results {
                case .success(let results):
                        for album in results.songs {
                            self?.songs.append(album)
                        }
                        self?.page += 1
                        self?.state = (results.songs.count == self?.limit) ? .good : .loadedAll
                    
                case .failure(let error):
                    self?.state = .error("could not load: \(error.localizedDescription)")
                }
            }
        }
       
    }
 
}
