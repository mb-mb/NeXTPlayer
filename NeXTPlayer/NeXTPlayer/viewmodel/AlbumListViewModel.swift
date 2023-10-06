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
    
    let service = APIService()
    @Published var searchTerm: String = ""
    @Published var albums: [Album] = [Album]()
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
            .removeDuplicates()
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
    
    func loadMock() -> AlbumListViewModel {
        let vm = AlbumListViewModel()
        vm.albums = [Album.example()]
        return vm
    }
    
    func fetchAlbum(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == .good else {
            return
        }
        
        state = .isLoading
        
        service.fetchAlbums(searchTerm: searchTerm, page: page, limit: limit ) {[weak self] results in            
            DispatchQueue.main.async {
                switch results {
                case .success(let results):
                        for var album in results.results {
                            self?.albums.append(album)
                        }
                        self?.page += 1
                        self?.state = (results.results.count == self?.limit) ? .good : .loadedAll
                        print("fetched Albums : \(results.resultCount)")

                case .failure(let error):
                    self?.state = .error("could not load: \(error.localizedDescription)")
                }
            }
        }
       
    }
    

    

}
