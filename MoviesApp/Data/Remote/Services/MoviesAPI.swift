//
//  UsersServices.swift
//  MoviesApp
//
//  Created by jorgehc on 11/25/17.
//  Copyright  2017 jorgehc.com All rights reserved.
//

import Foundation
import UIKit

class MoviesAPI: MoviesAPIProtocol {
    func getMovies(completion: @escaping (MoviesResponse?, String?) -> Void) {
        
    }
    
    func getMovie(movieId: Int, completion: @escaping (Movie?, String?) -> Void) {
    }
    
    func getLatestMovie(completion: @escaping (Movie?, String?) -> Void) {
        let sessionProvider = URLSessionProvider()
        sessionProvider.request(type: Movie.self, service: MovieService.latest) { response in // 2
            switch response { // 3
            case let .success(movie):
                completion(movie, nil)
            case let .failure(error):
                completion(nil, "error")
            }
        }
    }
    
    func getUpcomingMovies(completion: @escaping (MoviesResponse?, String?) -> Void) {
        let sessionProvider = URLSessionProvider()
        sessionProvider.request(type: MoviesResponse.self, service: MovieService.upcoming) { response in // 2
            switch response {
            case let .success(moviesResponse):
                completion(moviesResponse, nil)
            case let .failure(error):
                completion(nil, "error")
            }
        }
    }
    
    func getPopularMovies(completion: @escaping (MoviesResponse?, String?) -> Void) {
        let sessionProvider = URLSessionProvider()
        sessionProvider.request(type: MoviesResponse.self, service: MovieService.popular) { response in // 2
            switch response {
            case let .success(moviesResponse):
                completion(moviesResponse, nil)
            case let .failure(error):
                completion(nil, "error")
            }
        }
    }

}
