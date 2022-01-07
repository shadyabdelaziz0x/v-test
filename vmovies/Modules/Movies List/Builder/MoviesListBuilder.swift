//
//  MoviesListBuilder.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import UIKit

protocol MoviesListProtocol {
    func build(initialMovies: [Movie]?) -> UIViewController
}

class MoviesListBuilder : MoviesListProtocol {
    
    private var interactor : MoviesListInteractor!
    private var presenter  : MoviesListPresenter!
    private var view       : MoviesListViewController!
    private var router     : MoviesListRouter!
    
    func build(initialMovies: [Movie]?) -> UIViewController {
        do {
            registrInteractor()
            try registerView()
            registerRouter(MoviesListViewController: view)
            registerPresenter(initialMovies: initialMovies)
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
    
    private func registerPresenter(initialMovies: [Movie]?) {
        self.presenter = MoviesListPresenter(view: view, interactor: interactor, router: router, initialMovies: initialMovies)
        
    }
    private func registerRouter(MoviesListViewController : UIViewController){
        router = MoviesListRouter(moviesListViewController: MoviesListViewController)
    }
}
