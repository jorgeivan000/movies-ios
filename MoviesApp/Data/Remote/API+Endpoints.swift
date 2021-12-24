//
//  Endpoints.swift
//  MoviesApp
//
//  Created by jorgehc on 1/26/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import Foundation

protocol RemoteResource {
    var endpoint: String { get }
    var url: String { get }
}

enum Endpoints {
    enum Movies: RemoteResource {
        case current
        case latestMovies
        case upcomingMovies
        case popularMovies
        case movie
        case movies

        var endpoint: String {
            switch self {
            case .current:
                return url
            case .movie:
                return "\(url)/sign_up/register"
            case .movies:
                return "\(url)/sign_up/register"
            case .latestMovies:
                return "\(url)/movie/latest?api_key=\(InfoPlistHelper.lookUpFor(.tmdbApiKey) ?? "")"
            case .upcomingMovies:
                return "\(url)/movie/upcoming?api_key=\(InfoPlistHelper.lookUpFor(.tmdbApiKey) ?? "")"
            case .popularMovies:
                return "\(url)/movie/popular?api_key=\(InfoPlistHelper.lookUpFor(.tmdbApiKey) ?? "")"
            }
        }

        var url: String {
            switch self {
            case .movie, .movies, .current, .latestMovies, .upcomingMovies, .popularMovies:
                return APIConstants.apiBaseURL
            }
        }
    }
}
