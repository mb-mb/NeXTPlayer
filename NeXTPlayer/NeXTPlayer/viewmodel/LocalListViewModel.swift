//
//  LocalListViewModel.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 05/10/23.
//

import Foundation
import MediaPlayer
import Combine

class LocalListViewModel: ObservableObject {
    let service = APIService()
    let player = MPMusicPlayerController.applicationMusicPlayer
    @Published var searchTerm: String = ""
    @Published var albums: [Album] = [Album]()
    @Published var state: FetchState = .good {
        didSet {
            print("LocalListViewModel state changed to : \(state)")
        }
    }
    var subscription = Set<AnyCancellable>()

    
    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.state = .good
                self?.fetchLocalAlbum(for: term)
            }.store(in: &subscription)
    }
    
    
    func loadMore() {
        fetchLocalAlbum(for: searchTerm)
    }
    
    func fetchLocalAlbum(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == .good else {
            return
        }
        
        state = .isLoading
        
       
        let query = MPMediaQuery.songs()
        query.items
            .publisher
            .print()
            .sink { value in
                let album = Album(wrapperType: "collection", collectionType: "Album", id: 1, artistID: 2, amgArtistID: 3,
                                   artistName: value.first?.artist ?? "no name yet",
                                   collectionName: value.first?.albumTitle ?? "no album name",
                                  collectionCensoredName: "",
                                   artistViewURL: nil, collectionViewURL: "https://music.apple.com/us/album/jack-johnson-friends-best-of-kokua-festival-a/1440752312?uo=4",
                                   artworkUrl60: "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/43/d0/ba/43d0ba6b-6470-ad2d-0c84-171c1daea838/12UMGIM10699.rgb.jpg/60x60bb.jpg",
                                   artworkUrl100: "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/43/d0/ba/43d0ba6b-6470-ad2d-0c84-171c1daea838/12UMGIM10699.rgb.jpg/100x100bb.jpg",
                                   collectionPrice: 8.99, collectionExplicitness: "", trackCount: 15, copyright: nil, country: "USA", currency: "USD", releaseDate: "2012-01-01T08:00:00Z", primaryGenreName: "Rock")
                self.albums = [album]
            }
        
        
    }
    
}
