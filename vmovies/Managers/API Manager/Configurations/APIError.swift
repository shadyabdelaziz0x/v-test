//
//  APIError.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/7/22.
//

import Foundation

enum APIError: Error {
    case urlNotFound
    case failedToGetUrl
    case failedToParseData
    case unauthorized
    case noInternetConnection
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .urlNotFound:
            return "urlNotFound"
        case .failedToGetUrl:
            return "Failed to get url"
        case .failedToParseData:
            return "failed to parse data"
        case .unauthorized:
            return "unauthorized"
        case .noInternetConnection:
            return "No Internet Connection"
        }
    }
}
