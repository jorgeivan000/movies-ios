//
//  UITableView+Ext.swift
//  MoviesApp
//
//  Created by jorgehc on 11/26/17.
//  Copyright © 2017 jorgehc.com All rights reserved.
//

import UIKit

//MARK: - Helpers
extension UITableView {
    func dequeue<T: UITableViewCell>(_ cell: TableViewCellIdentifier, for indexPath: IndexPath, castingTo: T.Type) -> T {    
        return dequeueReusableCell(withIdentifier: cell.rawValue, for: indexPath) as! T
    }
    
    func registerCell(_ cell: TableViewCellIdentifier) {
        let tableViewCellNib = UINib(nibName: cell.rawValue, bundle: nil)
        register(tableViewCellNib, forCellReuseIdentifier: cell.rawValue)
    }
}

//MARK: - Empty State
extension UITableView {
    func setEmpty(message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Sophia Pro", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension UITableViewCell {
    func setBackgroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }
    
    func setBackgroundClearColor() {
        setBackgroundColor(.clear)
    }
}
