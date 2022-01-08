//
//  DownloadImageRoute.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/8/22.
//

import Foundation
import Alamofire
import PromiseKit

struct DownloadImageRoute: APIConfiguration {
    
    var urlParameters: [String : String]?    = nil
    var path          : String
    let method        : HTTPMethod           = .get
    let isAuth        : Bool                 = false
    let isPrintable   : Bool                 = true
    var appendBaseUrl : Bool                 = false

    init(params: DownloadImageRequest) {
        self.path = params.downloadUrl
    }
    
    func getParameters() throws -> Data? {
        return nil
    }
}
extension APIClient {
    func downloadImage(from url: String) -> Promise<Data> {
        return Promise { seal  in
            performRequest(route: DownloadImageRoute(params: DownloadImageRequest(downloadUrl: url))) {
                if let error = $1 {
                    seal.reject(error)
                    return
                }
                guard let data = $0 else {
                    seal.reject(APIError.failedToParseData)
                    return
                }
                seal.fulfill(data)
            }
        }
    }
}
