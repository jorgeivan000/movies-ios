//
//  Array+Ext.swift
//  MoviesApp
//
//  Created by jorgehc on 12/4/17.
//  Copyright © 2017 jorgehc.com All rights reserved.
//

import Foundation

// Example:
//
// Having -> let numbers = [1, 2, 3, 4, 5, 6]
//
// let groupedNumbers = numbers.grouped(by: { (number: Int) -> String in
//    if number % 2 == 1 {
//        return "odd"
//    } else {
//        return "even"
//    }
// })
extension Array {
    func grouped<T>(by criteria: (Element) -> T) -> [T: [Element]] {
        var groups = [T: [Element]]()
        for element in self {
            let key = criteria(element)
            if groups.keys.contains(key) == false {
                groups[key] = [Element]()
            }
            groups[key]?.append(element)
        }
        return groups
    }
    
    func chunks(_ chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}

extension Array where Element == String {
    
    /**
     Function for sorting an String Array alphabetically.
     If the string "#" is in the first element of the array it is removed and appended at the end.
     - Returns: An String Array sorted alphabetically
     */
    func sortedAlphabethically() -> [String] {
        var sortedArray = sorted(by: <)
        
        if sortedArray.first == "#" {
            sortedArray.removeFirst()
            sortedArray.append("#")
        }
        
        return sortedArray
    }
}
