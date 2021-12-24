//
//  Collection+Ext.swift
//  MoviesApp
//
//  Created by jorgehc on 3/21/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
