//
//  UpcomingMoviesPresenter.swift
//  MoviesApp
//
//  Created by jorgehc on 22/12/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation

class UpcomingMoviesPresenter: UpcomingMoviesViewPresenter {
    let view: UpcomingMoviesView!
    let movieService: MoviesAPIProtocol
    
    required init(view: UpcomingMoviesView, movieService: MoviesAPIProtocol) {
        self.view = view
        self.movieService = movieService
    }
    
    func fetchUpcomingMovies() {
        let realmManager = RealmManager()
        let doesUpcomingMoviesExist = realmManager.localMoviesExistsByCategory(MovieCategory.upcoming.rawValue)
        if doesUpcomingMoviesExist {
            self.loadMoviesFromDataBase()
        } else {
        self.view.setProgress(to: true)
        self.movieService.getUpcomingMovies(completion: { (moviesResponse, error) in
            self.view.setProgress(to: false)
            guard error == nil else {
                self.view.display(error)
                return
            }
            guard let currentMovies = moviesResponse?.movies else { return }
            for movie in currentMovies {
                movie.category = MovieCategory.upcoming.rawValue
            }
            realmManager.saveObjects(objs: currentMovies, type: Movie.self, deleteAll: false, onComplete: {
                self.loadMoviesFromDataBase()
            })
            return
        })
        }
    }
    
    func loadMoviesFromDataBase() {
        let realmManager = RealmManager.init()
        realmManager.getMoviesBy(category: MovieCategory.upcoming.rawValue) { moviesArray in
            self.view.displayUpcomingMovies(movies: moviesArray)
        }
    }
}
