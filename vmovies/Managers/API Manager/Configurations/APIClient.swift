//
//  APIClient.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/7/22.
//

import Foundation
import Alamofire
import PromiseKit

class APIClient: APIClientProtocol {
    
    typealias responseCallBack = (_ response: Data?, _ error: Error?) -> Void
    
    static let shared: APIClientProtocol = APIClient()
    
    func performRequest(route: APIConfiguration, completion: @escaping responseCallBack) {
        AF.request(route).validate().responseData { response in
            guard let data = response.data else {
                completion(nil, APIError.failedToParseData)
                return
            }
            if route.isPrintable {
                print(response.debugDescription)
            }
            switch response.result {
            case .success:
                completion(data, nil)
            case .failure(let serverError):
                if serverError.responseCode == 404 {
                    completion(data, APIError.urlNotFound)
                }
                completion(data, APIError.failedToParseData)
            }
        }
    }
}
