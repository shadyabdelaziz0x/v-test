//
//  MovieDetailsBuilder.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/7/22.
//

import UIKit

protocol MovieDetailsProtocol {
    func build(data: MovieDetailsData) -> UIViewController
}

class MovieDetailsBuilder : MovieDetailsProtocol {
    
    private var interactor : MovieDetailsInteractor!
    private var presenter  : MovieDetailsPresenter!
    private var view       : MovieDetailsViewController!
    private var router     : MovieDetailsRouter!
    
    func build(data: MovieDetailsData) -> UIViewController {
        do {
            registrInteractor()
            try registerView()
            registerRouter(movieDetailsViewController: view)
            registerPresenter(data: data)
            view.presenter = presenter
            interactor.presenter = presenter
            return view
        } catch  {
           return UIViewController()
        }
    }
    
    
    private func registrInteractor() {
        self.interactor = MovieDetailsInteractor()
    }
    
    private func registerView() throws {
        guard let movieDetailsViewController: MovieDetailsViewController = R.storyboard.movieDetailsStoryboard.movieDetailsViewController() else {
            throw NSError()
        }
        self.view = movieDetailsViewController
    }
    
    private func registerPresenter(data: MovieDetailsData) {
        self.presenter = MovieDetailsPresenter(view: view, interactor: interactor, router: router, data: data)
        
    }
    private func registerRouter(movieDetailsViewController : UIViewController){
        router = MovieDetailsRouter(movieDetailsViewController: movieDetailsViewController)
    }
}
