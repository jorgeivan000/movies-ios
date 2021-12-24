//
//  PopularMoviesContract.swift
//  MoviesApp
//
//  Created by jorgehc on 22/12/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation

protocol PopularMoviesView: BaseView {
    
    // Display Popular movies in collectionviewcell
    func displayPopularMovies(movies: [MovieStruct])
}

protocol PopularMoviesViewPresenter {
    init(view: PopularMoviesView, movieService: MoviesAPIProtocol)

    // Handle Popular movies fetching
    func fetchPopularMovies()
}
