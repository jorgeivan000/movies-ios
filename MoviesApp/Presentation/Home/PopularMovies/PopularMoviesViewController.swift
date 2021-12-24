//
//  PopularMoviesViewController.swift
//  MoviesApp
//
//  Created by jorgehc on 2/18/20.
//  Copyright © 2020 jorgehc.com. All rights reserved.
//

import Foundation
import UIKit

class PopularMoviesViewController: NotifiableBaseViewController, UICollectionViewDelegateFlowLayout {
    //MARK: - Outlets
    @IBOutlet var popularMoviesCollectionView: UICollectionView!
    @IBOutlet weak var userName: UILabel!
    //MARK: - Variables
    var popularMoviesList : [MovieStruct] = []
    //MARK: - Controller
    var presenter: PopularMoviesPresenter!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PopularMoviesPresenter(view: self, movieService: MoviesAPI())
        popularMoviesCollectionView.delegate = self
        popularMoviesCollectionView.dataSource = self
        popularMoviesCollectionView.registerCell(.movieCollectionViewCell)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name(rawValue: NotificationsID.reloadData.rawValue), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.fetchPopularMovies()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name(rawValue: NotificationsID.reloadData.rawValue),
                                                  object: nil)
    }
    
    @objc func reloadData() {
        presenter.fetchPopularMovies()
    }
}

//MARK: - PopularMoviesView
extension PopularMoviesViewController: PopularMoviesView {
    func displayPopularMovies(movies: [MovieStruct]) {
        DispatchQueue.main.async {
            self.popularMoviesList = movies
            self.popularMoviesCollectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDelegate
extension PopularMoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
                let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
                let size:CGFloat = (popularMoviesCollectionView.frame.size.width - space - 5.0) / 2.0
                return CGSize(width: size, height: (size / 3) * 4)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = popularMoviesList[indexPath.row]
        guard let movieDetailViewController = Navigator.get(controller: .movieDetail, from: .movieDetail) as? MovieDetailViewController else { return }
        movieDetailViewController.currentMovie = popularMoviesList[indexPath.row]
        self.navigationController!.pushViewController(movieDetailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMoviesList.count
    }

}

//MARK: - UICollectionViewDataSource
extension PopularMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifier.movieCollectionViewCell.rawValue, for: indexPath) as! MovieCollectionViewCell
            cell.isAccessibilityElement = true
            cell.setMovieInfo(movie: popularMoviesList[indexPath.row])
            return cell
    }
}
