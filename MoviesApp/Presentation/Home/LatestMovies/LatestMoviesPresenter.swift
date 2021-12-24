//
//  LatestMoviesPresenter.swift
//  MoviesApp
//
//  Created by jorgehc on 22/12/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation
class LatestMoviesPresenter: LatestMoviesViewPresenter {
    //MARK: - Variables
    let view: LatestMoviesView!
    let movieService: MoviesAPIProtocol
    
    required init(view: LatestMoviesView, movieService: MoviesAPIProtocol) {
        self.view = view
        self.movieService = movieService
    }
    
    func fetchLatestMovies() {
        let realmManager = RealmManager()
        let doesLatestMovieExist = realmManager.localMoviesExistsByCategory(MovieCategory.latest.rawValue)
        if doesLatestMovieExist {
            self.loadMoviesFromDataBase()
        } else {
            self.view.setProgress(to: true)
            self.movieService.getLatestMovie(completion: { (movie, error) in
                self.view.setProgress(to: false)
                guard error == nil else {
                    self.view.display(error)
                    return
                }
                movie?.category = MovieCategory.latest.rawValue
                var currentMovies = [Movie]()
                currentMovies.append(movie!)
                
                realmManager.saveObjects(objs: currentMovies, type: Movie.self, deleteAll: false, onComplete: {
                    self.loadMoviesFromDataBase()
                })
                return
            })
        }
    }
    
    func loadMoviesFromDataBase() {
        let realmManager = RealmManager.init()
        realmManager.getMoviesBy(category: MovieCategory.latest.rawValue) { moviesArray in
            self.view.displayLatestMovie(movie: moviesArray[0])
        }
    }
}
