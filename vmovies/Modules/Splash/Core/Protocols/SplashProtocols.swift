//
//  SplashProtocols.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import Foundation

protocol SplashViewToPresenter: AnyObject{
    func syncApp()
}

protocol SplashPresenterToView: AnyObject{
    
}

protocol SplashPresenterToInteractor: AnyObject{
    func syncMovies()
}

protocol SplashPresenterToRouter: AnyObject{
    func presentMoviesListModule(initialMovies: [Movie]?)
}

protocol SplashInteractorToPresenter: AnyObject{
    func fetchMoviesDidFinish(status: FetchFromApiStatus)
}
