//
//  MovieCollectionViewCell.swift
//  MoviesApp
//
//  Created by Jorge Herrera on 2/21/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviesPosterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieRating: UILabel!
    var movieStruct: MovieStruct?
    static let identifier = String(describing: MovieCollectionViewCell.self)
    
    override func awakeFromNib() {
           super.awakeFromNib()
        setup()
    }
    
    func setup() {
        self.contentView.backgroundColor = UIColor.white
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
    
    func setMovieInfo(movie: MovieStruct) {
        self.movieStruct = movie
        movieTitle.text = self.movieStruct?.title ?? "N/A"
        self.moviesPosterImage.isHidden = false
        if let movieURL = self.movieStruct?.posterPath {
            let imageURL: URL? = URL(string: movieURL)
            self.moviesPosterImage.sd_setShowActivityIndicatorView(true)
            self.moviesPosterImage.sd_setIndicatorStyle(.gray)
            self.moviesPosterImage.sd_setImage(with: imageURL!, completed: { (image, error, cacheType, imageURL) in
                            self.moviesPosterImage.cutRounded()
                        })
        } else {
            self.moviesPosterImage.image = UIImage(named: "posterPlaceholder")
        }
    }
    
    override var isHighlighted: Bool {
           didSet {
               if self.isHighlighted {
                self.contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
               } else {
                self.contentView.backgroundColor = UIColor.white
               }
           }
       }
}
