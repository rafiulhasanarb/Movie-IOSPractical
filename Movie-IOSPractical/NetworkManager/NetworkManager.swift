//
//  NetworkManager.swift
//  Movie-IOSPractical
//
//  Created by rafiul hasan on 22/8/22.
//

import Foundation
import Combine
import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    static let baseURL = "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query="
    
    init() {}
    
    //MARK: Combine used
    func request(from endpoint: URL) -> AnyPublisher<MovieModelResponse, APError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APError.unknown}
            .flatMap { data, response -> AnyPublisher<MovieModelResponse, APError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APError.unknown).eraseToAnyPublisher()
                }
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: MovieModelResponse.self, decoder: JSONDecoder())
                        .mapError{_ in APError.unknown}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    //MARK: URL Session used
    func loadMovies(completed: @escaping(Result<[MovieModel], APError>) -> Void) {
        guard let url = URL(string: NetworkManager.baseURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieModelResponse.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    //MARK: cache images used URLSession
    func downloadImage(fromURLString urlString: String, completed: @escaping(UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}
