//
//  MoviesManager.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/8/22.
//

import Foundation
import SQLite

class MoviesManager {
    
    private let dbConnection: Connection!
    private let movieTable = Table(Tables.Movie)
    
    private enum  MovieCol {
        static let id = Expression<String>(MovieEntity.id)
        static let author = Expression<String>(MovieEntity.author)
        static let width = Expression<Double>(MovieEntity.width)
        static var height = Expression<String>(MovieEntity.height)
        static let url = Expression<String>(MovieEntity.url)
        static let downloadUrl = Expression<Bool>(MovieEntity.downloadUrl)
        static let imageDownloaded = Expression<Bool>(MovieEntity.imageDownloaded)
    }
    
    init?(connection: Connection) throws {
        dbConnection = connection
        try createTable()
    }
    
    private func createTable() throws {
        try dbConnection?.run(movieTable.create(ifNotExists: true, block: { t in
            t.column(MovieCol.id, primaryKey: true)
            t.column(MovieCol.author)
            t.column(MovieCol.width)
            t.column(MovieCol.height)
            t.column(MovieCol.url)
            t.column(MovieCol.downloadUrl)
            t.column(MovieCol.imageDownloaded)
        }))
    }
    
    private func createMovie(row: Row) throws -> Movie {
        let movie: Movie = try row.decode()
        return movie
    }
}

extension MoviesManager: MoviesManagerProtocol {
    
    func delete() throws {
        guard let db = dbConnection else {
            throw DatabaseError.cannotRetrieveMovies
        }
        try db.run(movieTable.delete())
    }
    
    func getMovies() throws -> [Movie] {
        guard let db = dbConnection else {
            throw DatabaseError.cannotRetrieveMovies
        }
        let movies: [Movie] = try db.prepare(movieTable).map {
            try $0.decode()
        }
        return movies
    }
    
    func insertMovies(_ movies: [Movie]) throws {
        guard let _ = dbConnection else {
            throw DatabaseError.cannotRetrieveMovies
        }
        try movies.forEach {
            guard let _ = try getMovieIfExist($0.id) else {
                try insertMovie($0)
                return
            }
        }
    }
    
    func getNonDownloadedImageMovies() throws -> [Movie] {
        guard let db = dbConnection else {
            throw DatabaseError.cannotRetrieveMovies
        }
        let query = movieTable.filter(MovieCol.imageDownloaded == false)
        let movies: [Movie] = try db.prepare(query).map {
            try $0.decode()
        }
        return movies
    }
    
    func setImageDownloaded(movieId: String) throws {
        guard let db = dbConnection, let _ = try getMovieIfExist(movieId) else {
            throw DatabaseError.cannotRetrieveMovies
        }
        try db.run(movieTable.filter(MovieCol.id == movieId).update(
            MovieCol.imageDownloaded <- true
        ))
    }
    
    private func getMovieIfExist(_ movieId: String) throws -> Movie? {
        guard let db = dbConnection else {
            throw DatabaseError.cannotRetrieveMovies
        }
        guard let row = try db.pluck(movieTable.filter(MovieCol.id == movieId)) else {
            return nil
        }
        
        let movie: Movie = try row.decode()
        return movie
    }
    
    private func insertMovie(_ movie: Movie) throws {
        try dbConnection.run(movieTable.insert(movie))
    }
}


