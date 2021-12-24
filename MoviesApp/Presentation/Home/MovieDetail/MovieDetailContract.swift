//
//  MovieDetailContract.swift
//  MoviesApp
//
//  Created by jorgehc on 22/12/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation

protocol MovieDetailView: BaseView {
}

protocol MovieDetailViewPresenter {
    init(view: MovieDetailView)
}
