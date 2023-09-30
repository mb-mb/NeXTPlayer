//
//  ContentViewModel.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 12/10/21.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    private let stateMachine: StateMachine
    private var searchItems: [Artist] = []
    
    private var stateCancellable: AnyCancellable?
    private var searchCancelleble: AnyCancellable?
    
    @Published var searchText: String = ""
    @Published var state: StateMachine.State {
        willSet { leaveState(state) }
        didSet  { enterState(state) }
    }
    @Published var isConfiguring: Bool = false
    @Published var artistList: [Artist] = []
    @Published var albumsGroup: [Albums] = []
    @Published var album: Albums = Artist.artistAlbumData().first!
    
    var cancellable = Set<AnyCancellable>()
    var formatDate = DateFormatter()

    
    var showConfiguringCancelButton: Bool {
        return stateMachine.state == .configuring
    }
    
    init(stateMachine: StateMachine) {
        self.stateMachine = stateMachine
        self.state = stateMachine.state        
        self.stateCancellable = stateMachine.statePublisher
            .sink { state in
                self.state = state
            }
    }
    
    func searchStatusChanged(_ value: SearchBar.Status) {
        let event: StateMachine.Event = {
            switch value {
            case .searching: return .startConfig
            case .searched: return .search
            case .notSearching: return .cancel
            }
        }()
        stateMachine.tryEvent(event)
    }
    
    func createSearchResultsViewModel() -> SearchResultsViewModel {
        return SearchResultsViewModel(items: searchItems)
    }
}

// MARK:- Date / Time

extension ContentViewModel {
    func menuTime(timetoShow: Date? = Date()) -> String {
        formatDate.dateFormat = "HH:mm:ss d/MM/y"
        
        return formatDate.string(from: timetoShow ?? Date())
    }
}


// MARK:- artists
extension ContentViewModel {
    func fetchArtists() {
        NeXTApi.shared.fetchArtists()
        .sink(receiveCompletion: { completion  in
            switch completion {
            case .finished:
                print("finished fetchArtists")
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { artists in
            self.artistList = artists
        }).store(in: &self.cancellable)
    }
}

// MARK:- albums
extension ContentViewModel {
    func fetchAlbums(from: String) {
        NeXTApi.shared.fetchAlbums(from: from)
        .sink(receiveCompletion: { completion  in
            switch completion {
            case .finished:
                print("finished fetchAlbums")
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { albums in
            self.albumsGroup = albums
        }).store(in: &self.cancellable)
    }
}

// MARK: - Search
extension ContentViewModel {
    
    func search(_ text: String) {
        searchText = text
        stateMachine.tryEvent(.search)
    }
    
    private func search() {
//        searchCancelleble = imageService.search(text: searchText)?.sink(receiveCompletion: { completion in
//            switch completion {
//            case .finished: break
//            case .failure: self.stateMachine.tryEvent(.failure)
//            }
//        }, receiveValue: { items in
//            self.searchItems = items
//            self.stateMachine.tryEvent(.success)
//        })
    }
    
}


// MARK: - State changes
extension ContentViewModel {

    func leaveState(_ state: StateMachine.State) {
//        if case .configuring = state {
//            isConfiguring = false
//        }
    }
    
    func enterState(_ state: StateMachine.State) {
//        if case .configuring = state {
//            isConfiguring = true
//        }
//        if case .loading = state {
//            search()
//        }
    }
    
}
