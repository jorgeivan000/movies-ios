//
//  UsersServices.swift
//  MoviesApp
//
//  Created by jorgehc on 11/25/17.
//  Copyright  2017 jorgehc.com All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class MoviesAPI: MoviesAPIProtocol {
   
    func getMovie(movieId: Int, completion: @escaping (Movie?, String?) -> Void) {
        let request = ServerRequest<MoviesResponse>(endPoint: MoviesRouter.movie) { movieResponse, error in
            guard error == nil else {
                completion(nil, error ?? .moviesFailureError)
                return
            }
            //Finding the current movie
            if let movies = movieResponse?.movies {
                for movie in movies {
                    if movie.id == String(movieId) {
                        completion(movie, nil)
                    }
                }
            }
            completion(nil, nil)
            
        }
        serverRequest(request)
    }
    
    func getLatestMovie(completion: @escaping (Movie?, String?) -> Void) {
        let request = ServerRequest<Movie>(endPoint: MoviesRouter.latest) { movie, error in
            guard error == nil else {
                completion(nil, error ?? .moviesFailureError)
                return
            }
            completion(movie, nil)
        }
        serverRequest(request)
    }
    
    func getUpcomingMovies(completion: @escaping (MoviesResponse?, String?) -> Void) {
        let request = ServerRequest<MoviesResponse>(endPoint: MoviesRouter.upcoming) { moviesResponse, error in
            guard error == nil else {
                completion(nil, error ?? .moviesFailureError)
                return
            }
            completion(moviesResponse, nil)
        }
        serverRequest(request)
    }
    
    func getPopularMovies(completion: @escaping (MoviesResponse?, String?) -> Void) {
        let request = ServerRequest<MoviesResponse>(endPoint: MoviesRouter.popular) { moviesResponse, error in
            guard error == nil else {
                completion(nil, error ?? .moviesFailureError)
                return
            }
            completion(moviesResponse, nil)
        }
        serverRequest(request)
    }
    
    func getMovies(completion: @escaping (MoviesResponse?, String?) -> Void) {
        let request = ServerRequest<MoviesResponse>(endPoint: MoviesRouter.movies) { moviesResponse, error in
            guard error == nil else {
                completion(nil, error ?? .moviesFailureError)
                return
            }
            completion(moviesResponse, nil)
        }
        serverRequest(request)
    }

}
