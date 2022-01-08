//
//  MovieDetailsRouter.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/7/22.
//

import UIKit

class MovieDetailsRouter {
    var movieDetailsViewController: UIViewController

    init(movieDetailsViewController: UIViewController) {
        self.movieDetailsViewController = movieDetailsViewController
    }
}

// MARK:- MovieDetailsPresenterToRouter
extension MovieDetailsRouter: MovieDetailsPresenterToRouter {
    func back() {
        movieDetailsViewController.navigationController?.popViewController(animated: true)
    }
}
