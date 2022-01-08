//
//  GetMoviesRoute.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/7/22.
//

import Foundation
import Alamofire
import PromiseKit

struct GetMoviesRoute: APIConfiguration {
   
    let params        : GetMoviesRequest
    let urlParameters : [String : String]?

    init(params: GetMoviesRequest) {
        self.params        = params
        self.urlParameters = ["page" : "\(params.page)", "limit": "\(params.limit ?? 0)"]
    }
    
    var path          : String              { return "v2/list" }
    let method        : HTTPMethod           = .get
    let isAuth        : Bool                 = false
    let isPrintable   : Bool                 = true
    var appendBaseUrl : Bool                 = true

    func getParameters() throws -> Data? {
        return nil
    }
}

extension APIClient {
    func getMovies(page: Int, limit: Int?) -> Promise<[Movie]> {
        return Promise { seal  in
            performRequest(route: GetMoviesRoute(params: GetMoviesRequest(page: page, limit: limit))) {
                if let error = $1 {
                    seal.reject(error)
                    return
                }
                let decoder = JSONDecoder()
                guard let data = $0, let movies = try? decoder.decode([Movie].self, from: data) else {
                    seal.reject(APIError.failedToParseData)
                    return
                }
                seal.fulfill(movies)
            }
        }
    }
}
