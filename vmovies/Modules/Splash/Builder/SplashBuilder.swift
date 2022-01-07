//
//  SplashBuilder.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import UIKit

protocol SplashProtocol {
    func build() -> UIViewController
}

class SplashBuilder : SplashProtocol {
    
    private var interactor : SplashInteractor!
    private var presenter  : SplashPresenter!
    private var view       : SplashViewController!
    private var router     : SplashRouter!
    
    func build() -> UIViewController {
        do {
            registrInteractor(apiClient: APIClient.shared)
            try registerView()
            registerRouter(splashViewController: view)
            registerPresenter()
            view.presenter = presenter
            interactor.presenter = presenter
            return view
        } catch  {
           return UIViewController()
        }
    }
    
    
    private func registrInteractor(apiClient: APIClientProtocol) {
        self.interactor = SplashInteractor(apiClient: apiClient)
    }
    
    private func registerView() throws {
        guard let splashViewController: SplashViewController = R.storyboard.splash.splashViewController() else {
            throw NSError()
        }
        self.view = splashViewController
    }
    
    private func registerPresenter() {
        self.presenter = SplashPresenter(view: view, interactor: interactor, router: router)
        
    }
    private func registerRouter(splashViewController : UIViewController){
        router = SplashRouter(splashViewController: splashViewController)
    }
}
