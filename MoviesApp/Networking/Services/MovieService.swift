//
//  PostService.swift
//  NetworkLayer
//
//  Created by Marcin Jackowski on 06/09/2018.
//  Copyright © 2018 CocoApps. All rights reserved.
//

import Foundation

enum MovieService: ServiceProtocol {
    
    case all
    //case comments(postIt: Int)
    case latest
    case upcoming
    case popular
    
    var baseURL: URL {
        return URL(string: APIConstants.apiBaseURL)!
    }
    
    var path: String {
        switch self {
        case .all:
            return ""
        case .latest:
            return Endpoints.Movies.latestMovies.endpoint
        case .upcoming:
            return Endpoints.Movies.upcomingMovies.endpoint
        case .popular:
            return Endpoints.Movies.popularMovies.endpoint
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
        case .all, .latest, .upcoming, .popular:
            return .requestPlain
        //case let .comments(postId):
        //    let parameters = ["postId": postId]
        //    return .requestParameters(parameters)
        }
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
}
