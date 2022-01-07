//
//  MoviesListBuilder.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import UIKit

protocol MoviesListProtocol {
    func build() -> UIViewController
}

class MoviesListBuilder : MoviesListProtocol {
    
    private var interactor : MoviesListInteractor!
    private var presenter  : MoviesListPresenter!
    private var view       : MoviesListViewController!
    private var router     : MoviesListRouter!
    
    func build() -> UIViewController {
        do {
            registrInteractor()
            try registerView()
            registerRouter(MoviesListViewController: view)
            registerPresenter()
            view.presenter = presenter
            interactor.presenter = presenter
            return view
        } catch  {
           return UIViewController()
        }
    }
    
    
    private func registrInteractor() {
        self.interactor = MoviesListInteractor()
    }
    
    private func registerView() throws {
        guard let moviesListViewController: MoviesListViewController = R.storyboard.moviesList.moviesListViewController() else {
            throw NSError()
        }
        self.view = moviesListViewController
    }
    
    private func registerPresenter() {
        self.presenter = MoviesListPresenter(view: view, interactor: interactor, router: router)
        
    }
    private func registerRouter(MoviesListViewController : UIViewController){
        router = MoviesListRouter(moviesListViewController: MoviesListViewController)
    }
}
