//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by jorgehc on 2/18/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewController: NotifiableBaseViewController, MovieDetailView {
    //MARK: - Outlets
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    //MARK: - Variables
    public var currentMovie : MovieStruct?
    //MARK: - Controller
    var presenter: MovieDetailPresenter!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MovieDetailPresenter(view: self)
        setUpDetail()
    }
    
    func setUpDetail() {
        movieTitle.text = currentMovie?.title
        overview.text = currentMovie?.overview
        if let currentDate = currentMovie?.releaseDate {
            releaseDate.text = Date.stringFromDate(date: currentDate)
        } else {
            releaseDate.text = "N/A"
        }
        voteAverage.text = String(currentMovie?.voteAverage ?? 0.0)
        if let movieURL = self.currentMovie?.posterPath {
            let imageURL: URL? = URL(string: movieURL)
            self.posterImage.sd_setShowActivityIndicatorView(true)
            self.posterImage.sd_setIndicatorStyle(.gray)
            self.posterImage.sd_setImage(with: imageURL!, completed: { (image, error, cacheType, imageURL) in
                            self.posterImage.cutRounded()
                        })
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}
