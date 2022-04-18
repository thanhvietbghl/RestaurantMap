//
//  Location.swift
//  RestaurantMap
//
//  Created by Viet Phan on 14/04/2022.
//

import Foundation
import ObjectMapper

struct Location: Mappable {
    var address: String
    var city: String
    var zipCode: String
    var country: String
    var state: String
    var displayAddresses: [String]
    var crossStreets: String
    
    var fullAddress: String {
        displayAddresses.joined(separator: "\n")
    }
    
    init() {
        address = ""
        city = ""
        zipCode = ""
        country = ""
        state = ""
        displayAddresses = []
        crossStreets = ""
    }
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        address <- map["address1"]
        city <- map["city"]
        zipCode <- map["zipCode"]
        country <- map["country"]
        state <- map["state"]
        displayAddresses <- map["display_address"]
        crossStreets <- map["cross_streets"]
    }
}
