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
        print("HERERE")
    }

}

// MARK:- MoviesListPresenterToView
extension MoviesListViewController: MoviesListPresenterToView {
    
}

// MARK:- UITableViewDelegate
extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK:- UITableViewDataSource
extension MoviesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.row > 0 && (indexPath.row) % 5 == 0 {
            cell = moviesTableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.adPlaceHolderTableViewCell.identifier, for: indexPath)
        } else {
            cell = moviesTableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieTableViewCell.identifier, for: indexPath)
        }
        return cell
    }
    
    
}
