//
//  ErrorModel.swift
//  MoviesApp
//
//  Created by Jorge Herrera on 23/12/21.
//  Copyright © 2021 JorgeHC. All rights reserved.
//
import Foundation

class ServerErrorModel: Decodable {
    var status: Int = 500
    var code: String = .empty
    var errorDescription: String = .empty
    var message: String = .empty
    
    private enum CodingKeys: String, CodingKey {
        case status
        case code
        case error
        case message
    }
    
    init(status: Int, code: String, errorDescription: String, message: String) {
        self.status = status
        self.code = code
        self.errorDescription = errorDescription
        self.message = message
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let error = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .error)
        status = try error.decode(Int.self, forKey: .status)
        code = try error.decode(String.self, forKey: .code)
        errorDescription = try error.decode(String.self, forKey: .error)
        message = try error.decode(String.self, forKey: .message)
    }
}
