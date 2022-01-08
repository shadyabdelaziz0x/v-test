//
//  MovieDetailsPresenter.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/7/22.
//

import UIKit

class MovieDetailsPresenter {
    private weak var view  : MovieDetailsPresenterToView!
    private var interactor : MovieDetailsPresenterToInteractor
    private var router     : MovieDetailsPresenterToRouter
    private var data: MovieDetailsData
    
    init(view: MovieDetailsPresenterToView, interactor: MovieDetailsPresenterToInteractor, router: MovieDetailsPresenterToRouter, data: MovieDetailsData) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
        self.data       = data
    }
}

// MARK:- MovieDetailsViewToPresenter
extension MovieDetailsPresenter: MovieDetailsViewToPresenter {
    var movieAuthor: String {
        return data.movie.author
    }
    
    var movieAttachment: UIImage {
        return data.image
    }
    
    func didClickBack() {
        router.back()
    }
}

// MARK:- MovieDetailsInteractorToPresenter
extension MovieDetailsPresenter: MovieDetailsInteractorToPresenter {
    
}
