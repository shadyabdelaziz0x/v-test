//
//  APIConfiguration.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/7/22.
//

import Foundation
import Alamofire

struct API {
    struct Constants {
        static let baseURL = "https://picsum.photos/"
    }
    
    enum HTTPHeaderField: String {
        case authentication = "Authorization"
        case contentType    = "Content-Type"
        case acceptType     = "Accept"
        case acceptEncoding = "Accept-Encoding"
        case authToken      = "token"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
}

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var urlParameters: [String: String]? { get }
    var isAuth: Bool { get }
    var isPrintable: Bool { get }
    func getParameters() throws -> Data?
}


extension APIConfiguration {
    func asURLRequest() throws -> URLRequest {
        let urlString = API.Constants.baseURL + path

        guard  var url = URLComponents(string: urlString) else {
            throw APIError.failedToGetUrl
        }
        
        // URLParameters
        
        if let queryItems = urlParameters {
            let params = queryItems.map{ URLQueryItem(name: $0.key, value: $0.value) }
            url.queryItems = params
        }
        
        
        var urlRequest = URLRequest(url: try url.asURL())

        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
   
        urlRequest.setValue(API.ContentType.json.rawValue, forHTTPHeaderField: API.HTTPHeaderField.contentType.rawValue)
        
        if isAuth {
            urlRequest.setValue("token", forHTTPHeaderField: API.HTTPHeaderField.authToken.rawValue)
        }
        
        // Parameters
        do {
            if let parameters = try getParameters() {
                urlRequest.httpBody = parameters
            }
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        return urlRequest
    }
}
