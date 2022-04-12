//
//  APIBaseInput.swift
//  RestaurantMap
//
//  Created by Viet Phan on 08/04/2022.
//

import Foundation
import Alamofire

class APIBaseInput {

    var urlString: String
    var urlParams: [String : Any]?
    let method: HTTPMethod
    var parameters: [String : Any]?
    var headers: HTTPHeaders = [:]
    var encoding: ParameterEncoding
    
    init(urlString: String,
         method: HTTPMethod,
         parameters: [String : Any]?,
         urlParams: [String : Any]? = nil,
         encoding: ParameterEncoding? = JSONEncoding.default) {
        self.urlString = urlString
        self.method = method
        self.parameters = parameters
        if let encoding = encoding {
            self.encoding = encoding
        } else {
            self.encoding = method == .get ? URLEncoding.default : JSONEncoding(options: [])
        }
        self.urlParams = urlParams
    }

    var url: URL? {
        return URL(string: urlString)
    }
}

public struct AppEncoding: ParameterEncoding {
    private let data: Data?
    init(data: Data?) {
        self.data = data
    }
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {

        var urlRequest = try urlRequest.asURLRequest()
        urlRequest.httpBody = data

        return urlRequest
    }
}
