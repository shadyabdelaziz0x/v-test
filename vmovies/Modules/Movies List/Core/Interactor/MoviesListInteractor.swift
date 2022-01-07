//
//  MoviesListInteractor.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import Foundation
import PromiseKit

class MoviesListInteractor {

    weak var presenter: MoviesListInteractorToPresenter!
}

// MARK:- MoviesListPresenterToInteractor
extension MoviesListInteractor: MoviesListPresenterToInteractor {
    
}
