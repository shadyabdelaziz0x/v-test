//
//  SplashRouter.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import Foundation
import UIKit

class SplashRouter {
    var splashViewController: UIViewController

    init(splashViewController: UIViewController) {
        self.splashViewController = splashViewController
    }
}

// MARK:- SplashPresenterToRouter
extension SplashRouter: SplashPresenterToRouter {

    func presentMoviesListModule(initialMovies: [Movie]?) {
        let moviesListView = MoviesListBuilder().build(initialMovies: initialMovies)
        let navigationController = UINavigationController(rootViewController: moviesListView)
        navigationController.isNavigationBarHidden = true
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}
