//
//  MoviesListProtocols.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import UIKit

protocol MoviesListViewToPresenter: AnyObject{
    var moviesSectionsCount: Int { get }
    func getMoviesRowsPerSection(section: Int) -> Int
    func getMovie(section: Int, index: Int) -> Movie?
    func navigateToMovieDetails(for index: Int, with image: UIImage)
    func fetchMoreMovies()
}

protocol MoviesListPresenterToView: AnyObject{
    func reloadTable()
    func setError(error: Error)
}

protocol MoviesListPresenterToInteractor: AnyObject{
    func fetchMovies(page: Int)
}

protocol MoviesListPresenterToRouter: AnyObject{
    func navigateToMovieDetails(data: MovieDetailsData)
}

protocol MoviesListInteractorToPresenter: AnyObject{
    func fetchingMoviesDidFinished(status: FetchFromApiStatus)
}
