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
    private var moviesList: [[Movie]] = []
    private let CHUNK_SIZE: Int = 5
    private var page: Int
    
    init(view: MoviesListPresenterToView, interactor: MoviesListPresenterToInteractor, router: MoviesListPresenterToRouter, initialMovies: [Movie]?) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
        let movies = initialMovies ?? []
        self.moviesList = movies.chunked(into: movies.count < CHUNK_SIZE ? movies.count : CHUNK_SIZE)
        page = movies.count == 0 ? 1 : 2
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
    
    func getMovie(section: Int, index: Int) -> Movie? {
        return moviesList[safe: section]?[safe: index]
    }
    
    func navigateToMovieDetails(section: Int, index: Int, with image: UIImage) {
        guard let movie = moviesList[safe: section]?[safe: index] else {
            return
        }
        router.navigateToMovieDetails(data: MovieDetailsData(image: image, movie: movie))
    }
    
    func fetchMoreMovies() {
        interactor.fetchMovies(page: page)
    }
}

// MARK:- MoviesListInteractorToPresenter
extension MoviesListPresenter: MoviesListInteractorToPresenter {
    func fetchingMoviesDidFinished(status: FetchFromApiStatus) {
        switch status {
        case .success(let movies):
            guard let newMoviesList = movies as? [Movie], newMoviesList.count > 0
            else {
                view.stopActivityIndicator()
                return
            }
            page += 1
            moviesList.append(contentsOf: newMoviesList.chunked(into: CHUNK_SIZE))
            view.reloadTable()
        case .error(let error):
            view.setError(error: error)
        }
    }
}
