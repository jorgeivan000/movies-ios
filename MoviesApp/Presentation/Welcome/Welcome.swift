//
//  WelcomeContract.swift
//  MoviesApp
//
//  Created by jorgehc on 7/26/18.
//  Copyright © 2018 jorgehc.com. All rights reserved.
//

import Foundation

protocol WelcomeView: BaseView {
}

protocol WelcomeViewPresenter {
    init(view: WelcomeView)
}
