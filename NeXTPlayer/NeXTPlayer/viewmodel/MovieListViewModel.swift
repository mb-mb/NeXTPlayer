//
//  MovieViewModel.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 03/10/23.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    
    let service = APIService()
    @Published var searchTerm: String = ""
    @Published var movies: [Movie] = [Movie]()
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
                self?.movies = []
                self?.fetchMovie(for: term)
            }.store(in: &subscription)
    }
    
    func loadMore() {
        fetchMovie(for: searchTerm)
    }
    
    func fetchMovie(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == .good else {
            return
        }
        
        state = .isLoading
        
        service.fetchMovies(searchTerm: searchTerm,  page: page, limit: limit ) {[weak self] results in
            
            DispatchQueue.main.async {
                switch results {
                case .success(let results):
                    for movie in results.results {
                            self?.movies.append(movie)
                        }
                        self?.page += 1
                        self?.state = (results.results.count == self?.limit) ? .good : .loadedAll
                    
                case .failure(let error):
                    self?.state = .error("could not load: \(error.localizedDescription)")
                }
            }
        }
       
    }
    

    

}

