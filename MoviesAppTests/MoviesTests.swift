//
//  UserTests.swift
//  MoviesAppTests
//
//  Created by jorgehc on 2/8/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation
import XCTest
@testable import MoviesApp

class MoviesTests: MoviesAppTests {
    func testJSONMapping() throws {
        let url = searchResourceFileURL(resource: .user)
        let json = try Data(contentsOf: url!)
        let decoder = JSONDecoder()
        let _: User = try decoder.decode(User.self, from: json)
    }
}
