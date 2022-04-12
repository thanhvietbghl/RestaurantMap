//
//  APIService.swift
//  Durian
//
//  Created by Le Tuan on 1/3/21.
//

import Foundation
import Alamofire
import ObjectMapper
import RxSwift
import RxAlamofire

protocol APIServiceType {

    func request<T: Mappable>(_ input: APIBaseInput) -> Observable<T>

}

typealias JSONDictionary = [String: Any]
typealias JSONArray = [JSONDictionary]

final class APIService: APIServiceType {

    static let shared = APIService()
}

extension APIService {

    func request<T: Mappable>(_ input: APIBaseInput) -> Observable<T> {
        return request(input)
            .map { json -> T in
                if let output = T(JSON: json) {
                    return output
                }
                throw APIResponseError.invalidResponseData
        }
    }
}

// MARK: - Implemement methods
extension APIService {
    fileprivate func request(_ input: APIBaseInput) -> Observable<JSONDictionary> {
        let urlRequest = preprocessInput(input)
            .do(onNext: { input in
                print("====================Request====================")
                print("URL: \(input.urlString)\nMethod: \(input.method.rawValue)")
                print("Params: \(input.parameters ?? [:])\nHeaders: \(input.headers)")
                print("====================Request====================")
            })
            .flatMapLatest { input in
                Alamofire.Session.default.rx
                    .request(input.method,
                             input.urlString,
                             parameters: input.parameters,
                             encoding: input.encoding,
                             headers: input.headers)
        }
        .flatMapLatest { dataRequest -> Observable<DataResponse<Any, AFError>> in
            return dataRequest.rx.responseJSON()
        }
        .map { (dataResponse) -> JSONDictionary in
            print(dataResponse)
            return try self.processResponse(dataResponse, url: input.url)
        }
        .catch({ error -> Observable<JSONDictionary> in
            throw error
        })
        return urlRequest
    }
}

// MARK: - Proccess response
extension APIService {

    fileprivate func processResponse(_ response: DataResponse<Any, AFError>,
                                     url: URL?) throws -> JSONDictionary {
        var error: Error = APIResponseError.invalidResponseData
        let responseObject = response.result
        if let data = response.request?.httpBody {
            print(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "")
        }
        let statusCode: Int = response.response?.statusCode ?? 0
        var messageError = ""
        if let data = response.data {
            if let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? JSONDictionary {
                // Process Errors from BE
                let errors = json["errors"] as? [String]
                messageError = errors?.first ?? ""
                print(messageError)
                if statusCode == 401 {
                    let absoluteString = (url?.absoluteString ?? "")
                    print("❌ [\(statusCode)] " + absoluteString)
                }
            }
        }
        switch responseObject {
        case .success(let value) :
            if let json = value as? JSONDictionary, statusCode == 200 {
                print("👍 [\(statusCode)] " + (url?.absoluteString ?? ""))
                return json
            }

            if let jsonArray = value as? JSONArray, statusCode == 200 {
                print("👍 [\(statusCode)] " + (url?.absoluteString ?? ""))
                return ["data": jsonArray]
            }
            
            error = APIResponseError.message(messageError)
            print("❌ [\(statusCode)] " + (url?.absoluteString ?? ""))
            throw error
            
        case .failure(let error as NSError):
            if statusCode >= 200 && statusCode < 300 {
                print("❌ [\(statusCode)] " + (url?.absoluteString ?? ""))
                return JSONDictionary()
            }
            if statusCode == 401 {
                messageError = "Email or password is incorrect"
                print("❌ [\(statusCode)] " + (url?.absoluteString ?? ""))
                throw APIResponseError.message(messageError)
            }
            print("❌ [\(statusCode)] " + (url?.absoluteString ?? ""))
            throw error
        default:
            break
        }
        print("❌ [\(statusCode)] " + (url?.absoluteString ?? ""))
        throw error
    }

    fileprivate func preprocessInput(_ input: APIBaseInput) -> Observable<APIBaseInput> {
        return Observable.deferred {
            if let urlParams = input.urlParams, !urlParams.keys.isEmpty {
                var urlString = input.urlString + "?"
                for (index, key) in Array(urlParams.keys).enumerated() {
                    if let value = urlParams[key] {
                        urlString += "\(key)" + "=" + "\(value)"
                        if index < urlParams.keys.count - 1 {
                            urlString += "&"
                        }
                    }
                }
                input.urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
                print(input.urlString)
            }
            return Observable.just(input)
        }
    }
}
