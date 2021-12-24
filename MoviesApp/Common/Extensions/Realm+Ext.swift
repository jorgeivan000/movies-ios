//
//  Realm+Ext.swift
//  MoviesApp
//
//  Created by jorgehc on 09/01/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
