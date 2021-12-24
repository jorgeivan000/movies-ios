//
//  PopularMoviesPresenter.swift
//  MoviesApp
//
//  Created by jorgehc on 22/12/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation
class PopularMoviesPresenter: PopularMoviesViewPresenter {
    let view: PopularMoviesView!
    let movieService: MoviesAPIProtocol
    
    required init(view: PopularMoviesView, movieService: MoviesAPIProtocol) {
        self.view = view
        self.movieService = movieService
    }
    
    func fetchPopularMovies() {
        let realmManager = RealmManager()
        let doesPopularMoviesExist = realmManager.localMoviesExistsByCategory(MovieCategory.popular.rawValue)
        if doesPopularMoviesExist {
            self.loadMoviesFromDataBase()
        } else {
        self.view.setProgress(to: true)
        self.movieService.getPopularMovies(completion: { (moviesResponse, error) in
            self.view.setProgress(to: false)
            guard error == nil else {
                self.view.display(error)
                return
            }
            guard let currentMovies = moviesResponse?.movies else { return }
            for movie in currentMovies {
                movie.category = MovieCategory.popular.rawValue
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
        realmManager.getMoviesBy(category: MovieCategory.popular.rawValue) { moviesArray in
            self.view.displayPopularMovies(movies: moviesArray)
        }
    }
}
