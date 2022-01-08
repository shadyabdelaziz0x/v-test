//
//  SplashInteractor.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import Foundation
import AwaitKit

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
            do{
                let movies = try await(self.apiClient.getMovies(page: 1, limit: 20))
                DispatchQueue.main.async {
                    self.presenter.fetchMoviesDidFinish(status: .success(movies))
                }
                for movie in movies {
                    let imageData = try await(self.apiClient.downloadImage(from: movie.downloadUrl))
                    LocalStorageManager.shared.saveImage(imageData: imageData, with: movie.id)
                }
            } catch {
                DispatchQueue.main.async {
//                    self.presenter.fetchMoviesDidFinish(status: .error(error))
                    self.presenter.fetchMoviesDidFinish(status: .success([Movie(id: "", author: "", width: 10, height: 10, url: "", downloadUrl: "")]))
                }
            }
        }
    }
}
