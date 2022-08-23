//
//  MovieListViewModel.swift
//  Movie-IOSPractical
//
//  Created by rafiul hasan on 22/8/22.
//

import Foundation
import Combine

enum ResultState {
    case loading
    case failed(error: Error)
    case success(content: [MovieModel])
}

class MovieListViewModel: ObservableObject {
    //MARK: Properties
    @Published var movies: [MovieModel] = []
    @Published private(set) var state: ResultState  = .loading
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: Methods
    func fetchMovieData(urlEndpoint: String) {
        self.state = .loading
        let cancellable = NetworkManager()
            .request(from: URL(string: NetworkManager.baseURL+urlEndpoint)!)
            .sink { (res) in
                switch res {
                case .failure(let error):
                    self.state = .failed(error: error)
                case .finished:
                    self.state = .success(content: self.movies)
                }
            } receiveValue: { res in
                self.movies = res.results
            }
        self.cancellables.insert(cancellable)
    }
    
    func getMovies() {
        //isLoading = true
        NetworkManager.shared.loadMovies { [self] result in
            DispatchQueue.main.async {
                //isLoading = false
                switch result {
                case .success(let movies):
                    self.movies = movies
                case .failure(let error):
                    switch error {
                    case .invalidResponse:
                        print(error.localizedDescription)
                        //alertItem = AlertContext.invalidResponse
                    case .invalidURL:
                        print(error.localizedDescription)
                        //alertItem = AlertContext.invalidURL
                    case .invalidData:
                        print(error.localizedDescription)
                        //alertItem = AlertContext.invalidData
                        print(error.localizedDescription)
                    case .unableToComplete:
                        print(error.localizedDescription)
                        //alertItem = AlertContext.unableToComplete
                    case .errorCode(_):
                        print(error.localizedDescription)
                    case .unknown:
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }    
}
