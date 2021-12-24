//
//  AppDelegate+Testing.swift
//  MoviesApp
//
//  Created by jorgehc on 8/15/18.
//  Copyright 2018 jorgehc.com. All rights reserved.
//

import Foundation
extension AppDelegate {
    
    static var isUITestingEnabled: Bool {
        get {
            return ProcessInfo.processInfo.arguments.contains("UI-Testing")
        }
    }
}
