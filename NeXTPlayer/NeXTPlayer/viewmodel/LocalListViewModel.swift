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
    @Published var artists: [LocalArtist] = []
    @Published var albums: [Album] = [Album]()
    @Published var songs: [LocalSong2] = [LocalSong2]()
    @Published var state: FetchState = .good {
        didSet {
            print("LocalListViewModel state changed to : \(state)")
        }
    }
    var cancellables = Set<AnyCancellable>()

    
    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.state = .good
                self?.fetchLocalAlbum(for: term)
            }.store(in: &cancellables)

    }
    
    
    func loadMore() {
        fetchLocalAlbum(for: searchTerm)
    }
    
    func loadMock() -> LocalListViewModel {
        let vm = LocalListViewModel()
        vm.albums = [Album.example(),Album.example(),Album.example(),Album.example(),Album.example(),Album.example()]
        return vm
    }
    
    
    func fetchLocalAlbum(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == .good else {
            return
        }
        
        state = .isLoading
        
       
        let query = MPMediaQuery.albums()
        query.items
            .publisher
            .print()
            .sink { value in
                let album = Album(wrapperType: "collection", collectionType: "Album", id: 1, artistID: 2, amgArtistID: 3,
                                  artistName: value.first?.artist ?? "no name yet",
                                  collectionName: value.first?.albumTitle ?? "no album name",
                                  collectionCensoredName: "",
                                  artistViewURL: nil,
                                  collectionViewURL: "https://music.apple.com/us/album/jack-johnson-friends-best-of-kokua-festival-a/1440752312?uo=4",
                                  artworkUrl60: "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/43/d0/ba/43d0ba6b-6470-ad2d-0c84-171c1daea838/12UMGIM10699.rgb.jpg/60x60bb.jpg",
                                  artworkUrl100: "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/43/d0/ba/43d0ba6b-6470-ad2d-0c84-171c1daea838/12UMGIM10699.rgb.jpg/100x100bb.jpg",
                                  collectionPrice: 8.99,
                                  collectionExplicitness: "", trackCount: 15, copyright: nil, country: "USA", currency: "USD", releaseDate: "2012-01-01T08:00:00Z", primaryGenreName: "Rock")
                self.albums = [album]
            }.store(in: &cancellables)
        
        
    }
    
    func fetchLocalArtists2() -> some Publisher<[LocalArtist], APIError> {
        return Future<[LocalArtist], APIError> { promise in
            let query = MPMediaQuery.artists()
            
            guard let collections = query.collections else {
                promise(.failure(.fetchFailed))
                return
            }
            
            let localArtists = collections.compactMap { collection -> LocalArtist? in
                guard let representativeItem = collection.representativeItem else {
                    return nil
                }
                return MPMediaItemToArtistMapper.map(mpMediaItem: representativeItem)
            }
            
            promise(.success(localArtists))
        }
        .eraseToAnyPublisher()
    }
    
    func fetchLocalSongs2() -> some Publisher<[LocalSong2], APIError> {
        return Future<[LocalSong2], APIError> { promise in
            let query = MPMediaQuery.songs()
            
            guard let collections = query.collections else {
                promise(.failure(.fetchFailed))
                return
            }
            
            let localSongs = collections.compactMap { collection -> LocalSong2? in
                guard let representativeItem = collection.representativeItem else {
                    return nil
                }
                return MPMediaItemToSongMapper.map(mpMediaItem: representativeItem)
            }
            
            promise(.success(localSongs))
        }
        .eraseToAnyPublisher()
    }

    func fetchLocalArtists() -> some Publisher<[LocalArtist], APIError> {
        let query = MPMediaQuery.artists()

        return Just(query)
            .tryMap { query -> [MPMediaItemCollection] in
                guard let collections = query.collections else {
                    throw APIError.fetchFailed
                }
                return collections
            }
            .print()
            .map { collections -> [LocalArtist] in
                collections.compactMap { collection in
                    guard let representativeItem = collection.representativeItem else {
                        return nil
                    }
                    return MPMediaItemToArtistMapper.map(mpMediaItem: representativeItem)
                }
            }
            .compactMap { $0 }
            .print()
            .mapError { error -> APIError in
                if let apiError = error as? APIError {
                    return apiError
                } else {
                    return .unknow
                }
            }
            .eraseToAnyPublisher()
    }

    func fetchLocalAlbuns(for artist: String) -> some Publisher<[Album], APIError> {
        return fetchLocalArtists2()
            .map { artists in
                return artists.filter { $0.name == artist }
            }
            .tryMap { filteredArtists-> [Album] in
                guard let firstArtist = filteredArtists.first else {
                    throw APIError.artistNotFound
                }
                
                // Use MPMediaQuery to fetch albums for the selected artist
                let albumQuery = MPMediaQuery.albums()
                albumQuery.addFilterPredicate(MPMediaPropertyPredicate(
                    value: firstArtist.id,
                    forProperty: MPMediaItemPropertyArtistPersistentID,
                    comparisonType: .equalTo
                ))
                
                if let albumItems = albumQuery.collections {
                    let albums = albumItems.compactMap { collection -> Album? in
                        guard let representativeItem = collection.representativeItem else {
                            return nil
                        }
                        // Map MPMediaItem to your Album struct
                        return Album(wrapperType: "collection", collectionType: "Album",
                                     id: Int(representativeItem.albumPersistentID), artistID: 2,
                                     amgArtistID: 3,
                                     artistName: "Jack Johnson & Friends",
                                     collectionName: representativeItem.albumTitle ?? "", collectionCensoredName: "",
                                     artistViewURL: nil,
                                     collectionViewURL: "https://music.apple.com/us/album/jack-johnson-friends-best-of-kokua-festival-a/1440752312?uo=4",
                                     artworkUrl60: "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/43/d0/ba/43d0ba6b-6470-ad2d-0c84-171c1daea838/12UMGIM10699.rgb.jpg/60x60bb.jpg",
                                     artworkUrl100: "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/43/d0/ba/43d0ba6b-6470-ad2d-0c84-171c1daea838/12UMGIM10699.rgb.jpg/100x100bb.jpg",
                                     collectionPrice: 8.99, collectionExplicitness: "", trackCount: 15, copyright: nil, country: "USA", currency: "USD", releaseDate: "2012-01-01T08:00:00Z", primaryGenreName: "Rock")
                    }
                    return albums
                } else {
                    throw APIError.fetchFailed
                }
            }
            .catch { error -> AnyPublisher<[Album], APIError> in
                if let apiError = error as? APIError {
                    return Fail(error: apiError).eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.unknow).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
            
    }

    
}
