//
//  MoviesListRouter.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import UIKit

class MoviesListRouter {
    var moviesListViewController: UIViewController

    init(moviesListViewController: UIViewController) {
        self.moviesListViewController = moviesListViewController
    }
}

// MARK:- MoviesListPresenterToRouter
extension MoviesListRouter: MoviesListPresenterToRouter {

}
