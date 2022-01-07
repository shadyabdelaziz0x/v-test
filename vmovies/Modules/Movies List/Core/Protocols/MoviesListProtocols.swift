//
//  MoviesListProtocols.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import Foundation

protocol MoviesListViewToPresenter: AnyObject{
    var moviesCount: Int { get }
    func getMovie(for index: Int) -> Movie?
}

protocol MoviesListPresenterToView: AnyObject{
    
}

protocol MoviesListPresenterToInteractor: AnyObject{
    
}

protocol MoviesListPresenterToRouter: AnyObject{
    
}

protocol MoviesListInteractorToPresenter: AnyObject{

}
