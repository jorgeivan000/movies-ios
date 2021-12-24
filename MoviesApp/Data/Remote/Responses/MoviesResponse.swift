//
//  AccountsResponse.swift
//  MoviesApp
//
//  Created by jorgehc on 26/11/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation

class MoviesResponse: Decodable {
    
    var movies: [Movie]?
    
    private enum CodingKeys: CodingKey {
        case results
    }
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    required init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.movies = [Movie]()
        if let currentMovies = try container.decodeIfPresent([Movie].self, forKey: .results) {
            self.movies = currentMovies
        }
    }
}
