//
//  InfoPlistHelper.swift
//  MoviesApp
//
//  Created by jorgehc on 12/19/17.
//  Copyright © 2017 jorgehc.com. All rights reserved.
//

import Foundation

enum InfoPlistKey: String {
    case api = "CoreAPIURL"
    case apiVersion = "CoreApiVersion"
    case tmdbApiKey = "TmdbApiKey"
}

class InfoPlistHelper {
    class func lookUpFor(_ key: InfoPlistKey) -> Any? {
        guard let infoPlist = Bundle.main.infoDictionary, let value = infoPlist[key.rawValue] else {
            debugPrint("There is no info plist value")
            return nil
        }
        debugPrint("Looking for \(value) for key \(key)")
        return value
    }
}

enum ResourcesNames: String {
    case mapSkin = "map-skin"
}

class BundleHelper {
    class func jsonFileURL(for resourceName: ResourcesNames) -> URL? {
        guard let overlayFileURLString = Bundle.main.path(forResource: resourceName.rawValue, ofType: "json") else {
            return nil
        }
        return URL(fileURLWithPath: overlayFileURLString)
    }
}
