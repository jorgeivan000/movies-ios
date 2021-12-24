//
//  UsersAPIProtocol.swift
//  MoviesApp
//
//  Created by jorgehc on 1/3/18.
//  Copyright 2018 jorgehc.com. All rights reserved.
//

import Foundation
import UIKit

protocol MoviesAPIProtocol: RemoteDataSource, DataProvider {
    func getMovie(movieId: Int, completion: @escaping (Movie?, String?) -> Void)
    func getMovies(completion: @escaping (MoviesResponse?, String?) -> Void)
    func getLatestMovie(completion: @escaping (Movie?, String?) -> Void)
    func getUpcomingMovies(completion: @escaping (MoviesResponse?, String?) -> Void)
    func getPopularMovies(completion: @escaping (MoviesResponse?, String?) -> Void)
}
