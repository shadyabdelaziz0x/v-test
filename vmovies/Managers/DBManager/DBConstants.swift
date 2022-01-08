//
//  DBConstants.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/8/22.
//

import Foundation

enum Database {
    static let fileName = "movies.sqlite"
}


enum Tables {
    static let Movie = "movies"
}

enum MovieEntity {
    static let id                         = "id"
    static let author                     = "author"
    static let width                      = "width"
    static let height                     = "height"
    static let url                        = "url"
    static let downloadUrl                = "download_url"
    static let imageDownloaded            = "image_downloaded"
}

enum DatabaseError: Error {
    case cannotInitDatabase
    case cannotRetrieveMovies
    case error
}

extension DatabaseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .cannotInitDatabase:
                return "Cannot Init Database"
            case .cannotRetrieveMovies:
                return "Cannot Retrieve Movies"
            case .error:
                return "Database error"
        }
    }
    
}
