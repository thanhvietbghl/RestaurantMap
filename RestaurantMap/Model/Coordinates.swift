//
//  coordinates.swift
//  RestaurantMap
//
//  Created by Viet Phan on 14/04/2022.
//

import Foundation
import ObjectMapper

struct Coordinates: Mappable {
    var latitude: Double
    var longitude: Double

    init() {
        latitude = 0
        longitude = 0
    }
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}
