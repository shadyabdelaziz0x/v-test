//
//  APIClientProtocol.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/7/22.
//

import Foundation
import PromiseKit

protocol APIClientProtocol: AnyObject {
    func getMovies(page: Int, limit: Int?) -> Promise<[Movie]>
    func downloadImage(from url: String) -> Promise<Data>
}
