//
//  LatestMoviesViewController.swift
//  MoviesApp
//
//  Created by jorgehc on 2/18/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation
import UIKit

class LatestMoviesViewController: NotifiableBaseViewController, UICollectionViewDelegateFlowLayout {
    //MARK: - Outlets
    @IBOutlet var latestMoviesCollectionView: UICollectionView!
    @IBOutlet weak var userName: UILabel!
    //MARK: - Variables
    var latestMoviesList : [MovieStruct] = []
    //MARK: - Controller
    var presenter: LatestMoviesPresenter!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LatestMoviesPresenter(view: self, movieService: MoviesAPI())
        latestMoviesCollectionView.delegate = self
        latestMoviesCollectionView.dataSource = self
        latestMoviesCollectionView.registerCell(.movieCollectionViewCell)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name(rawValue: NotificationsID.reloadData.rawValue), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.fetchLatestMovies()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name(rawValue: NotificationsID.reloadData.rawValue),
                                                  object: nil)
    }
    
    @objc func reloadData() {
        presenter.fetchLatestMovies()
    }
}

//MARK: - LatestMoviesView
extension LatestMoviesViewController: LatestMoviesView {
    func displayLatestMovie(movie: MovieStruct) {
        DispatchQueue.main.async {
            self.latestMoviesList = []
            self.latestMoviesList.append(movie)
            self.latestMoviesCollectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDelegate
extension LatestMoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return latestMoviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = latestMoviesList[indexPath.row]
        guard let movieDetailViewController = Navigator.get(controller: .movieDetail, from: .movieDetail) as? MovieDetailViewController else { return }
        movieDetailViewController.currentMovie = movie
        self.navigationController!.pushViewController(movieDetailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
                let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
                let size:CGFloat = (latestMoviesCollectionView.frame.size.width - space - 5.0) / 2.0
                return CGSize(width: size, height: (size / 3) * 4)
    }
}

//MARK: - UICollectionViewDataSource
extension LatestMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = latestMoviesList[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.movieCollectionViewCell.rawValue, for: indexPath) as! MovieCollectionViewCell
            cell.isAccessibilityElement = true
            cell.setMovieInfo(movie: movie)
            return cell
    }
}
