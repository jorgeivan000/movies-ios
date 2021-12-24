//
//  LatestContract.swift
//  MoviesApp
//
//  Created by jorgehc on 22/12/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation

protocol LatestMoviesView: BaseView {
    
    // Display latest movies in collectionviewcell
    func displayLatestMovie(movie: MovieStruct)
}

protocol LatestMoviesViewPresenter {
    init(view: LatestMoviesView, movieService: MoviesAPIProtocol)

    // Handle latest movies fetching
    func fetchLatestMovies()
}
