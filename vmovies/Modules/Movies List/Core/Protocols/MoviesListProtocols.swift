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
    func getMovie(for index: Int) -> Movie?
    func navigateToMovieDetails(for index: Int, with image: UIImage)
}

protocol MoviesListPresenterToView: AnyObject{
    
}

protocol MoviesListPresenterToInteractor: AnyObject{
    
}

protocol MoviesListPresenterToRouter: AnyObject{
    func navigateToMovieDetails(data: MovieDetailsData)
}

protocol MoviesListInteractorToPresenter: AnyObject{

}
