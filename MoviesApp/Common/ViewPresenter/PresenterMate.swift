//
//  PresenterMate.swift
//  MoviesApp
//
//  Created by jorgehc on 11/16/17.
//  Copyright © 2017 jorgehc.com. All rights reserved.
//

import Foundation

protocol PresenterMate {
    associatedtype Presenter
    var presenter: Presenter { get set }    
}
