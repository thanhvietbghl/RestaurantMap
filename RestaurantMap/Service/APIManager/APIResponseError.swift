//
//  APIResponseError.swift
//  RestaurantMap
//
//  Created by Viet Phan on 08/04/2022.
//

import Foundation
import ObjectMapper

struct APIResponseErrorMessage {
    static let invalidResponseData = "Data is invalid"
    static let serverInternalError = "Server Internal Error"
}

enum APIResponseError: Error {
    case invalidResponseData
    case expiredToken
    case error
    case unknown(statusCode: Int)
    case message(String)
    case serverInternalError

    static func getErrorMessage(from error: Error) -> String {
        if let error = error as? APIResponseError {
            switch error {
            case .message(let message): return message
            case .invalidResponseData: return APIResponseErrorMessage.invalidResponseData
            case .serverInternalError: return APIResponseErrorMessage.serverInternalError
            default: return error.localizedDescription
            }
        } else {
            return error.localizedDescription
        }
    }
}

enum SpecialError: Error {
    case networkNotConnected
    case sessionExpired
}
