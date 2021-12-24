//
//  UpcomingMoviesContract.swift
//  MoviesApp
//
//  Created by jorgehc on 22/12/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation

protocol UpcomingMoviesView: BaseView {
    
    // Display Upcoming movies in collectionviewcell
    func displayUpcomingMovies(movies: [MovieStruct])
}

protocol UpcomingMoviesViewPresenter {
    init(view: UpcomingMoviesView, movieService: MoviesAPIProtocol)

    // Handle Upcoming movies fetching
    func fetchUpcomingMovies()
}
