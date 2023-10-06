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
    var defaultLimits = 100
    
    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.state = .good
                self?.movies = []
                self?.fetchMovie(for: term)
            }.store(in: &subscription)
    }
    
    func loadMore() {
        fetchMovie(for: searchTerm)
    }
    
    
    func loadMock() -> MovieListViewModel {
        let vm = MovieListViewModel()
        vm.movies = [Movie.example()]
        return vm
    }
    
    
    
    func fetchMovie(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == .good else {
            return
        }
        
        state = .isLoading
        
        service.fetchMovies(searchTerm: searchTerm) {[weak self] results in            
            DispatchQueue.main.async {
                switch results {
                case .success(let results):
                    self?.movies = results.results
                    if results.resultCount == self?.defaultLimits {
                        self?.state = .good
                    } else {
                        self?.state = .loadedAll
                    }
                    print("fetched movies : \(results.resultCount)")
                case .failure(let error):
                    self?.state = .error("could not load: \(error.localizedDescription)")
                }
            }
        }
       
    }
    

    

}

