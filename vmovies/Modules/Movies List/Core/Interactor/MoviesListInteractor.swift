//
//  MoviesListInteractor.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import Foundation
import AwaitKit

class MoviesListInteractor {

    weak var presenter: MoviesListInteractorToPresenter!
    private let apiClient: APIClientProtocol!
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
}

// MARK:- MoviesListPresenterToInteractor
extension MoviesListInteractor: MoviesListPresenterToInteractor {
    func fetchMovies(page: Int) {
        DispatchQueue.global(qos: .background).async {
            do {
                let movies: [Movie] = try await(self.apiClient.getMovies(page: page, limit: AppConstants.shared.MOVIES_BATCH_SIZE))
                self.fetchingMoviesDidFinished(status: .success(movies))
            } catch let error {
                self.fetchingMoviesDidFinished(status: .error(error))
            }
        }
    }
    
    private func fetchingMoviesDidFinished(status: FetchFromApiStatus) {
        DispatchQueue.main.sync {
            self.presenter.fetchingMoviesDidFinished(status: status)
        }
    }
}
