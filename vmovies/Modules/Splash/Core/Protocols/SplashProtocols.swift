//
//  SplashProtocols.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import Foundation

protocol SplashViewToPresenter: AnyObject{
    func navigateToMoviesList()
}

protocol SplashPresenterToView: AnyObject{
    
}

protocol SplashPresenterToInteractor: AnyObject{
    
}

protocol SplashPresenterToRouter: AnyObject{
    func presentMoviesListModule()
}

protocol SplashInteractorToPresenter: AnyObject{

}
