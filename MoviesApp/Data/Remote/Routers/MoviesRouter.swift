//
//  UsersRouter.swift
//  MoviesApp
//
//  Created by jorgehc on 11/25/17.
//  Copyright 2017 jorgehc.com All rights reserved.
//

import Foundation
import Alamofire

enum UserKeys: String {
    case user
    case name
}

enum MoviesRouter: AuthenticatedRouter, RequestDecorable {
    var authToken: String {
        return .empty
    }
    
    case current
    case movie
    case movies
    case latest
    case upcoming
    case popular

    var method: HTTPMethod {
        switch self {
        case .current,
             .movie,
             .movies,
             .latest,
             .upcoming,
             .popular:
            return .get
        }
    }

    var path: String {
        switch self {
        case .current:
            return Endpoints.Movies.current.url
        case .movie:
            return Endpoints.Movies.movie.endpoint
        case .movies:
            return Endpoints.Movies.movies.endpoint
        case .latest:
            return Endpoints.Movies.latestMovies.endpoint
        case .upcoming:
            return Endpoints.Movies.upcomingMovies.endpoint
        case .popular:
            return Endpoints.Movies.popularMovies.endpoint
        }
    }

    // MARK: Customize Request
    func decorate(_ urlRequest: inout URLRequest) throws -> URLRequest {
        switch self {
            /*
        case .update(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .updateProfilePicture:
             urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: AppHeaders.contentType)
             */
        default:
            break
        }
        return urlRequest
    }
}
