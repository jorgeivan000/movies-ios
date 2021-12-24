//
//  UsersAPIMocks.swift
//  MoviesApp
//
//  Created by jorgehc on 1/3/18.
//  Copyright 2018 jorgehc.com. All rights reserved.
//

import Foundation
import UIKit

class MoviesAPI: UsersAPIProtocol {
    func getMovie(completion: @escaping (Account?, String?) -> Void) {
        completion(getAccountObject(), nil)
    }
    
    func getMovies(completion: @escaping (AccountsResponse?, String?) -> Void) {}
}
