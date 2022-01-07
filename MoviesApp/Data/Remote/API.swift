//
//  APIClient.swift
//  MoviesApp
//
//  Created by jorgehc on 11/24/17.
//  Copyright © 2017 jorgehc.com All rights reserved.
//

import Foundation

struct APIConstants {
    static let apiVersion = "/api/\(InfoPlistHelper.lookUpFor(.apiVersion) ?? "")"
    static let apiBaseURL = "\(InfoPlistHelper.lookUpFor(.api) ?? "")"
    static let appBaseURL = "\(InfoPlistHelper.lookUpFor(.api) ?? "")/app"
}

struct AppHeaders {
    static let authKey = "Authorization"
    static let contentType = "Content-Type"
    // HERE: Add your headers keys
}

