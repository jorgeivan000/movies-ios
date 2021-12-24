//
//  MovieDetailPresenter.swift
//  MoviesApp
//
//  Created by jorgehc on 22/12/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation
class MovieDetailPresenter: MovieDetailViewPresenter {
    let view: MovieDetailView!
    
    required init(view: MovieDetailView) {
        self.view = view
    }
}
