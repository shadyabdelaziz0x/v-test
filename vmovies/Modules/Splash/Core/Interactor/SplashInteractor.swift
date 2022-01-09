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
    private let apiClient: APIClientProtocol!
    private let dbManager: DBManager
    private let localStorageManager: LocalStorageManager!
    
    init(dbManager: DBManager, apiClient: APIClientProtocol, localStorageManager: LocalStorageManager) {
        self.apiClient = apiClient
        self.dbManager = dbManager
        self.localStorageManager = localStorageManager
    }
}

// MARK:- SplashPresenterToInteractor
extension SplashInteractor: SplashPresenterToInteractor {
    func syncMovies() {
        //check if fetching first 20 movies and saving them is done
        let mainSyncDone = localStorageManager.defaults.mainSyncDone
        DispatchQueue.global(qos: .background).async {
            do{
                var movies: [Movie] = []
                if mainSyncDone {
                    movies = try self.dbManager.moviesManager.getMovies()
                    self.fetchMoviesDidFinished(status: .success(movies))
                } else {
                    movies = try await(self.apiClient.getMovies(page: 1, limit: AppConstants.shared.MOVIES_BATCH_SIZE))
                    self.fetchMoviesDidFinished(status: .success(movies))
                    try self.dbManager.moviesManager.insertMovies(movies)
                    self.localStorageManager.defaults.mainSyncDone = true
                }
                self.downloadImagesForSavedData()
            } catch let error {
                self.fetchMoviesDidFinished(status: .error(error))
            }
        }
    }
    
    private func downloadImagesForSavedData() {
        let isCashFull = localStorageManager.defaults.isCashFull
        guard !isCashFull else {
            return
        }
        do {
            let movies = try self.dbManager.moviesManager.getNonDownloadedImageMovies()
            for movie in movies {
                if !movie.imageDownloaded {
                    let imageData = try await(self.apiClient.downloadImage(from: movie.downloadUrl))
                    self.localStorageManager.saveImage(imageData: imageData, with: movie.id)
                    try self.dbManager.moviesManager.setImageDownloaded(movieId: movie.id)

                }
            }
            self.localStorageManager.defaults.isCashFull = true
        } catch let error {
            print("Failed to cach images : \(error)")
        }
    }
    
    private func fetchMoviesDidFinished(status: FetchFromApiStatus) {
        DispatchQueue.main.async {
            self.presenter.fetchMoviesDidFinish(status: status)
        }
    }
}
