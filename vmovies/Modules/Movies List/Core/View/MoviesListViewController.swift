//
//  MoviesListViewController.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import UIKit

class MoviesListViewController: UIViewController {

    var presenter: MoviesListViewToPresenter!
    @IBOutlet private weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK:- MoviesListPresenterToView
extension MoviesListViewController: MoviesListPresenterToView {
    
}

// MARK:- UITableViewDelegate
extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

// MARK:- UITableViewDataSource
extension MoviesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.moviesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row) % 5 == 0 {
            guard let cell = moviesTableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.adPlaceHolderTableViewCell.identifier, for: indexPath) as? AdPlaceHolderTableViewCell else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = moviesTableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell, let movie = presenter.getMovie(for: indexPath.row) else { return UITableViewCell() }
            cell.bind(movie: movie)
            return cell
        }
    }
}
