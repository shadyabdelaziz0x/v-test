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
    
    init(view: MoviesListPresenterToView, interactor: MoviesListPresenterToInteractor, router: MoviesListPresenterToRouter) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
    }
}

// MARK:- MoviesListViewToPresenter
extension MoviesListPresenter: MoviesListViewToPresenter {
}

// MARK:- MoviesListInteractorToPresenter
extension MoviesListPresenter: MoviesListInteractorToPresenter {
    
}
