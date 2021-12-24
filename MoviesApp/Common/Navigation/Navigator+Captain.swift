//
//  NavigationHelper.swift
//  MoviesApp
//
//  Created by Erick A. Montañez  on 11/29/17.
//  Copyright © 2017 jorgehc.com All rights reserved.
//

import Foundation

//MARK: Nodes
public enum Segue {
}

public enum Storyboard: String {
    case home = "Home"
    case welcome = "Welcome"
    case latestMoviesTab = "LatestMovies"
    case popularMoviesTab = "PopularMovies"
    case upcomingMoviesTab = "UpcomingMovies"
    case movieDetail = "MovieDetail"
    case noInternet = "NoInternet"
}

public enum Controller: String {
    case home = "TabbedHomeViewController"
    case welcome = "WelcomeViewController"
    case latestMoviesTab = "LatestMoviesViewController"
    case popularMoviesTab = "PopularMoviesViewController"
    case upcomingMoviesTab = "UpcomingMoviesViewController"
    case movieDetail = "MovieDetailViewController"
    case noInternet = "NoInternetViewController"
}
