//
//  FetchFromApiStatus.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/7/22.
//

import Foundation

enum FetchFromApiStatus {
    case success([Codable])
    case error(Error)
}
