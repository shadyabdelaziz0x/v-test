//
//  GetMoviesRequest.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/7/22.
//

import Foundation

struct GetMoviesRequest: Codable {
    let page: Int
    let limit: Int?
}
