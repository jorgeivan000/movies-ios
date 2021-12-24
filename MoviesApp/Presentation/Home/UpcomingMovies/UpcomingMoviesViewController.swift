//
//  UpcomingMoviesViewController.swift
//  MoviesApp
//
//  Created by jorgehc on 2/18/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation
import UIKit

class UpcomingMoviesViewController: NotifiableBaseViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Outlets
    @IBOutlet var upcomingMoviesCollectionView: UICollectionView!
    @IBOutlet weak var userName: UILabel!
    //MARK: - Variables
    var upcomingMoviesList : [MovieStruct] = []
    //MARK: - Controller
    var presenter: UpcomingMoviesPresenter!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = UpcomingMoviesPresenter(view: self, movieService: MoviesAPI())
        upcomingMoviesCollectionView.delegate = self
        upcomingMoviesCollectionView.dataSource = self
        upcomingMoviesCollectionView.registerCell(.movieCollectionViewCell)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name(rawValue: NotificationsID.reloadData.rawValue), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.fetchUpcomingMovies()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name(rawValue: NotificationsID.reloadData.rawValue),
                                                  object: nil)
    }
    
    @objc func reloadData() {
        presenter.fetchUpcomingMovies()
    }
}

//MARK: - UpcomingMoviesView
extension UpcomingMoviesViewController: UpcomingMoviesView {
    func displayUpcomingMovies(movies: [MovieStruct]) {
        DispatchQueue.main.async {
            self.upcomingMoviesList = movies
            self.upcomingMoviesCollectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDelegate
extension UpcomingMoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
                let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
                let size:CGFloat = (upcomingMoviesCollectionView.frame.size.width - space - 5.0) / 2.0
                return CGSize(width: size, height: (size / 3) * 4)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = upcomingMoviesList[indexPath.row]
        guard let movieDetailViewController = Navigator.get(controller: .movieDetail, from: .movieDetail) as? MovieDetailViewController else { return }
        movieDetailViewController.currentMovie = movie
        self.navigationController!.pushViewController(movieDetailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingMoviesList.count
    }
}

//MARK: - UICollectionViewDataSource
extension UpcomingMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let account = upcomingMoviesList[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.movieCollectionViewCell.rawValue, for: indexPath) as! MovieCollectionViewCell
            cell.isAccessibilityElement = true
        cell.setMovieInfo(movie: upcomingMoviesList[indexPath.row])
            return cell
    }
}
