//
//  SplashInteractor.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import Foundation
import AwaitKit
import PromiseKit

class SplashInteractor {

    weak var presenter: SplashInteractorToPresenter!
    private var apiClient: APIClientProtocol!
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
}

// MARK:- SplashPresenterToInteractor
extension SplashInteractor: SplashPresenterToInteractor {
    func fetchMovies() {
        DispatchQueue.global(qos: .background).async {
            self.apiClient.getMovies(page: 1, limit: 20).done { (movies) in
                DispatchQueue.main.async {
                    self.presenter.fetchMoviesDidFinish(status: .success(movies))
                }
            }.catch { (error) in
                DispatchQueue.main.async {
                    self.presenter.fetchMoviesDidFinish(status: .error(error))
                }
            }
        }
    }
}
