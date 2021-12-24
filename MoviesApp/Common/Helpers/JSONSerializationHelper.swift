//
//  JSONSerializationHelper.swift
//  MoviesApp
//
//  Created by jorgehc on 7/22/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation

final class JSONSerializationHelper {
    static func convertToJsonObject(_ jsonString: String) -> Data? {
        do {
            guard let data = jsonString.data(using: .utf8) else {
                debugPrint("UTF Error")
                return nil
            }
            return data
        }
    }
}
