//
//  SongsForAlbumListViewModel.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 05/10/23.
//

import Foundation

class SongsForAlbumListViewModel: ObservableObject {
    @Published var songs = [Song]()
    @Published var state: FetchState = .good {
        didSet {
            print("state changed to : \(state)")
        }
    }
    let service = APIService()
    let albumID: Int
    
    init(albumID: Int) {
        self.albumID = albumID
        print("init for songs for album \(albumID)")
    }
    
    
    func fetch() {
        fetchSongs(for: albumID)
    }
    
    func fetchSongs(for albumID: Int) {
        service.fetchSongs(for: albumID) { [weak self] results in
            DispatchQueue.main.async {
                switch results {
                case .success(let results):
                    self?.songs = results.results
                    if results.results.count > 0 {
                        _ = self?.songs.removeFirst()
                    }
                    self?.state =  .good
                    print("fetched \(results.resultCount) songs for albumID: \(albumID)")
                    
                case .failure(let error):
                    self?.state = .error("could not load: \(error.localizedDescription)")
                }
            }
        }
    }
    
    static func example() -> SongsForAlbumListViewModel {
        let vm = SongsForAlbumListViewModel(albumID: 1)
        vm.songs = [Song.example(), Song.example2()]
        print("mock songs for album \(1) has \(vm.songs.count) item")
        return vm
    }
 }
