//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by jorgehc on 7/19/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import XCTest
@testable import MoviesApp

enum Resources: String, CaseIterable {
    case movie = "Movie"
}

class MovieAppTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func searchResourceFileURL(resource: Resources) -> URL? {
        let bundle = Bundle(for: type(of: self))
        let resource = resource.rawValue
        guard let url = bundle.url(forResource: resource, withExtension: "json") else {
            XCTFail("Missing file: \(resource).json")
            return nil
        }
        return url
    }
}
