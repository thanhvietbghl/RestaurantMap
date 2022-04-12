//
//  APIBaseOutput.swift
//  RestaurantMap
//
//  Created by Viet Phan on 08/04/2022.
//

import Foundation
import ObjectMapper

class APIBaseOutput: Mappable {
    
    var status: String = ""
    var message: String = ""
    
    required init?(map: Map) {
    }

    func mapping(map: Map) {
        status <- map["status"]
        message <- map["error_message"]
    }

    var errorMessageDisplaying: String {
        return message
    }
}
