//
//  TabbedHomePresenter.swift
//  MoviesApp
//
//  Created by Jorge Herrera on 5/7/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation
class TabbedHomePresenter: TabbedHomeViewPresenter {
    let view: TabbedHomeView!
    let movieService: MoviesAPIProtocol!
    
    required init(view: TabbedHomeView, movieService: MoviesAPIProtocol) {
        self.view = view
        self.movieService = movieService
    }
}
