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
    private var moviesList: [[Movie]] = []
    private let CHUNK_SIZE: Int = 5
    
    init(view: MoviesListPresenterToView, interactor: MoviesListPresenterToInteractor, router: MoviesListPresenterToRouter, initialMovies: [Movie]?) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
        self.movies = initialMovies ?? []
        self.moviesList = movies.chunked(into: movies.count < CHUNK_SIZE ? movies.count : CHUNK_SIZE)
    }
}

// MARK:- MoviesListViewToPresenter
extension MoviesListPresenter: MoviesListViewToPresenter {
    var moviesSectionsCount: Int {
        return moviesList.count
    }
    
    func getMoviesRowsPerSection(section: Int) -> Int {
        return moviesList[safe: section]?.count ?? 0
    }
    
    func getMovie(for index: Int) -> Movie? {
        return movies[safe: index]
    }
    
    func navigateToMovieDetails(for index: Int, with image: UIImage) {
        guard let movie = movies[safe: index] else {
            return
        }
        router.navigateToMovieDetails(data: MovieDetailsData(image: image, movie: movie))
    }
}

// MARK:- MoviesListInteractorToPresenter
extension MoviesListPresenter: MoviesListInteractorToPresenter {
    
}
