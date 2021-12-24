//
//  BaseView.swift
//  MoviesApp
//
//  Created by jorgehc on 12/15/17.
//  Copyright © 2017 jorgehc.com. All rights reserved.
//

import UIKit

protocol BaseView: class {
    func setProgress(to isLoading: Bool, with alpha: CGFloat?, overlay: UIColor?)
    func display(_ message: String?)
    func displayWithTitle(_ title: String?, message: String?)
}
