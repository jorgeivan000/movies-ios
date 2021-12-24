//
//  AuthenticateResponse.swift
//  MoviesApp
//
//  Created by jorgehc on 8/31/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import Foundation

class AuthenticateResponse: Decodable {

    var acessToken: String
    var type: String
    var lastConnection: String?
    
    private enum CodingKeys: CodingKey {
        case accessToken
        case type
        case lastConnection
    }
    
    init(accessToken: String, type: String, lastConnection: String? = nil) {
        self.acessToken = accessToken
        self.type = type
        self.lastConnection = lastConnection
    }
    
    required init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        acessToken = try container.decode(String.self, forKey: .accessToken)
        type = try container.decode(String.self, forKey: .type)
        lastConnection = try container.decodeIfPresent(String.self, forKey: .lastConnection)
    }
}
