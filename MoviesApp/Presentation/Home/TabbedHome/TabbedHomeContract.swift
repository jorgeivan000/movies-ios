//
//  TabbedHomeContract.swift
//  MoviesApp
//
//  Created by Jorge Herrera on 5/7/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation

protocol TabbedHomeView: BaseView {
}

protocol TabbedHomeViewPresenter {
    /**
     Initializer for TabbedViewPresenter
     */
    init(view: TabbedHomeView, movieService: MoviesAPIProtocol)
}
