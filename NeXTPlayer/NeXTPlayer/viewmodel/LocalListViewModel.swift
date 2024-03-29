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
    @Published private var artistPublisher: AnyPublisher<[LocalArtist], APIError>?
    @Published private var albumsPublisher: AnyPublisher<[LocalAlbum], APIError>?
    @Published private var songPublisher: AnyPublisher<[LocalSong], APIError>?
    @Published var artists: [LocalArtist] = []
    @Published var albums: [LocalAlbum] = [LocalAlbum]()
    @Published var songs: [LocalSong] = [LocalSong]()
    @Published var state: FetchState = .good {
        didSet {
            print("LocalListViewModel state changed to : \(state)")
        }
    }
    @Published var stateAlbums: FetchState = .good {
        didSet {
            print("LocalListViewModel stateAlbums changed to : \(stateAlbums)")
        }
    }
    
    
    @Published var isAuthorized: Bool = false {
        didSet {
            print("LocalListViewModel isAuthorized changed to : \(isAuthorized)")
        }
    }
    
    var cancellables = Set<AnyCancellable>()

    
    init() {        
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.albums = []
                self?.state = .good
                self?.fetchLocalArtist(for: term)
            }.store(in: &cancellables)
        
        checkAuthorizationStatus()
    }
    
    
    func loadMore() {
        fetchLocalArtist(for: "")
        fetchLocalAlbuns(artistName: "")
    }
    
    func loadMock() -> LocalListViewModel {
        let vm = LocalListViewModel()
        vm.artists = LocalArtist.mockData()
        vm.albums = LocalAlbum.mockData()
        vm.songs = LocalSong.mock()

        return vm
    }
    
    func mockData() {
        self.artists = LocalArtist.mockData()
        self.albums = LocalAlbum.mockData()
        self.songs = LocalSong.mock()
    }
    
    func setSelectedArtist(artist: LocalArtist) {
        if let name = artist.name {
            // it's not nevessary do sink or set albums, it's already done in
            // publisher albumsPublisher
            self.fetchLocalAlbuns(artistName: name)
                .sink ( receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("fetchLocalAlbuns finished")
                    case .failure(let receivedError):
                       print(receivedError) // Handle the error
                    }
                }, receiveValue: {[weak self] localAlbums in
                    print("fetchLocalAlbuns receiveValue: \(localAlbums.count)")
                    var albums_temp: [LocalAlbum] = []
                    if localAlbums.count >= 0 {
                        for album in localAlbums {
                            print(album)
                            albums_temp.append(album)
                        }
                    }
                    
                    let sortedAlbums = albums_temp.sorted { $0.collectionName < $1.collectionName }
                    self?.albums = sortedAlbums                    
                    
                })
                .store(in: &cancellables)

        }
    }

    func fetchLocalArtist(for searchTerm: String) {
                       
        stateAlbums = .isLoading
        
        
        let query = MPMediaQuery.albums()
        
        if !searchTerm.isEmpty {
            query.addFilterPredicate(MPMediaPropertyPredicate(
                value: searchTerm,
                forProperty: MPMediaItemPropertyArtist,
                comparisonType: .contains
            ))
        }
        
        query.items
            .publisher
            .map { items in
                var artistDict = [String: MPMediaItem]()
                
                // Iterate through the MPMediaItems and add them to the dictionary, using the artist name as the key
                items.forEach { item in
                    if let artist = item.artist, artistDict[artist] == nil {
                        artistDict[artist] = item
                    }
                }
                
                // Convert the dictionary values (MPMediaItems) to an array
                let uniqueItems = Array(artistDict.values)
                
                return uniqueItems
            }
            .sink { [weak self] value in
                var artists_temp: [LocalArtist] = []
                _ = value.map { item in
                    let localArtist = LocalArtist(artist: item, artistState: .stop)
                    artists_temp.append(localArtist)
                }
                
                let sortedArtists = artists_temp.sorted { artist1, artist2 in
                    // Ensure that name properties are non-nil before comparing
                    guard let name1 = artist1.name, let name2 = artist2.name else {
                        // You might need to define a default behavior if name is nil
                        return false
                    }
                    
                    // Compare the names in ascending order
                    return name1 < name2
                }
                
                self?.artists = sortedArtists
                self?.state = .loadedAll
                
            }
            .store(in: &cancellables)
    }
    
    
    func fetchLocalAlbum(for searchTerm: String) {
        stateAlbums = .isLoading
        
       
        let query = MPMediaQuery.albums()
        query.items
            .publisher
            .print()
            .sink { value in
                _ = value.map { item in
                    let localAlbum = LocalAlbum(album: item, artistState: .stop)
                    self.albums = [localAlbum]
                }
                
            }.store(in: &cancellables)
        
        self.stateAlbums = .loadedAll
        
    }
    
    func fetchLocalArtists2() -> AnyPublisher<[LocalArtist], APIError> {
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

    func fetchAlbuns(artist: String) -> AnyPublisher<[Album], APIError> {
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

    func fetchLocalAlbuns(artistName: String) -> AnyPublisher<[LocalAlbum], APIError> {
        self.stateAlbums = .isLoading
        return Future<[LocalAlbum], APIError> { promise in
            // Use MPMediaQuery to fetch albums for the selected artist
            let albumQuery = MPMediaQuery.albums()
            albumQuery.addFilterPredicate(MPMediaPropertyPredicate(
                value: artistName,
                forProperty: MPMediaItemPropertyArtist, 
                comparisonType: .equalTo
            ))
            
            if let albumItems = albumQuery.collections {
                let albums = albumItems.compactMap { collection -> LocalAlbum? in
                    guard let representativeItem = collection.representativeItem else {
                        return nil
                    }
                    // Map MPMediaItem to your Album struct
                    return LocalAlbum(album: representativeItem, artistState: .stop)
                }
                self.stateAlbums = .loadedAll
                return promise(.success(albums))
            } else {
                self.stateAlbums = .loadedAll
                promise(.failure(APIError.fetchFailed))
            }

        }
        .eraseToAnyPublisher()
    }
    
    func requestAuthorization() {
        MPMediaLibrary.requestAuthorization {[weak self] status in
            DispatchQueue.main.async {
                self?.isAuthorized = status == .authorized
                self?.loadMore()
            }
        }
    }
    
    func checkAuthorizationStatus() {
        isAuthorized = MPMediaLibrary.authorizationStatus() == .authorized
    }
}
