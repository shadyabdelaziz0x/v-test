//
//  MoviesListPresenter.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import UIKit

class MoviesListPresenter {
    private weak var view  : MoviesListPresenterToView!
    private var interactor : MoviesListPresenterToInteractor
    private var router     : MoviesListPresenterToRouter
    private var movies: [Movie] = []
    
    init(view: MoviesListPresenterToView, interactor: MoviesListPresenterToInteractor, router: MoviesListPresenterToRouter, initialMovies: [Movie]?) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
        self.movies = initialMovies ?? []
    }
}

// MARK:- MoviesListViewToPresenter
extension MoviesListPresenter: MoviesListViewToPresenter {
    var moviesCount: Int {
        return movies.count
    }
    
    func getMovie(for index: Int) -> Movie? {
        guard index > 0 && index < moviesCount else {
            return nil
        }
        return movies[index]
    }
}

// MARK:- MoviesListInteractorToPresenter
extension MoviesListPresenter: MoviesListInteractorToPresenter {
    
}
