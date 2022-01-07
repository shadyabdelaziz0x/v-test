//
//  SplashPresenter.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import UIKit

class SplashPresenter {
    private weak var view  : SplashPresenterToView!
    private var interactor : SplashPresenterToInteractor
    private var router     : SplashPresenterToRouter
    
    init(view: SplashPresenterToView, interactor: SplashPresenterToInteractor, router: SplashPresenterToRouter) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
    }
}

// MARK:- SplashViewToPresenter
extension SplashPresenter: SplashViewToPresenter {
    func navigateToMoviesList() {
        router.presentMoviesListModule()
    }
}

// MARK:- SplashInteractorToPresenter
extension SplashPresenter: SplashInteractorToPresenter {
    
}

