//
//  UICollectionView+Ext.swift
//  MoviesApp
//
//  Created by Erick A. Montañez  on 11/29/17.
//  Copyright © 2017 jorgehc.com All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(_ cell: CollectionViewCellIdentifier, for indexPath: IndexPath, castingTo: T.Type) -> T {
        return dequeueReusableCell(withReuseIdentifier: cell.rawValue, for: indexPath) as! T
    }
    
    func registerCell(_ cell: CollectionViewCellIdentifier) {
        let collectionViewCellNib = UINib(nibName: cell.rawValue, bundle: nil)
        register(collectionViewCellNib, forCellWithReuseIdentifier: cell.rawValue)
    }
    
    func registerClass(_ cell: AnyClass, cellIdentifier: CollectionViewCellIdentifier) {
        register(cell, forCellWithReuseIdentifier: cellIdentifier.rawValue)
    }
}
