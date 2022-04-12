//
//  Restaurant.swift
//  RestaurantMap
//
//  Created by Viet Phan on 08/04/2022.
//

import Foundation
import ObjectMapper

struct Restaurant: Mappable {
    var businessStatus: String
    var geometry: Geometry
    var icon: String
    var iconBackgroundColor: String
    var iconMaskBaseUri: String
    var name: String
    var placeId: String
    var plusCode: PlusCode
    var reference: String
    var scope: String
    var types: [String]
    var vicinity: String
    
    init() {
        businessStatus = ""
        geometry = Geometry()
        icon = ""
        iconBackgroundColor = ""
        iconMaskBaseUri = ""
        name = ""
        placeId = ""
        plusCode = PlusCode()
        reference = ""
        scope = ""
        types = []
        vicinity = ""
    }
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        businessStatus <- map["business_status"]
        geometry <- map["geometry"]
        icon <- map["icon"]
        iconBackgroundColor <- map["icon_background_color"]
        iconMaskBaseUri <- map["icon_mask_base_uri"]
        name <- map["name"]
        placeId <- map["place_id"]
        plusCode <- map["plus_code"]
        reference <- map["reference"]
        scope <- map["scope"]
        types <- map["types"]
        vicinity <- map["vicinity"]
    }
}

struct Geometry: Mappable {
    
    var location: Location
    
    init?(map: Map) {
        self.init()
    }
    
    init() {
        location = Location()
    }
    
    mutating func mapping(map: Map) {
        location <- map["location"]
    }
}

struct Location: Mappable {
    var lat: Double
    var lng: Double
    var viewPort: ViewPort
    
    init?(map: Map) {
        self.init()
    }
    
    init() {
        lat = 0
        lng = 0
        viewPort = ViewPort()
    }
    
    mutating func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
        viewPort <- map["viewPort"]
    }
}
struct ViewPort: Mappable {
    var northeast: LocationPort
    
    init?(map: Map) {
        self.init()
    }
    
    init() {
        northeast = LocationPort()
    }
    
    mutating func mapping(map: Map) {
        northeast <- map["northeast"]
    }
}

struct Southwest: Mappable {
    var southwest: LocationPort
    
    init?(map: Map) {
        self.init()
    }
    
    init() {
        southwest = LocationPort()
    }
    
    mutating func mapping(map: Map) {
        southwest <- map["southwest"]
    }
    
}

struct LocationPort: Mappable {
    var lat: Double
    var lng: Double
    
    init?(map: Map) {
        self.init()
    }
    
    init() {
        lat = 0
        lng = 0
    }
    
    mutating func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
    }
}

struct PlusCode: Mappable {
    var compoundCode: String
    var globalCode: String
    
    init?(map: Map) {
        self.init()
    }
    
    init() {
        compoundCode = ""
        globalCode = ""
    }
    
    mutating func mapping(map: Map) {
        compoundCode <- map["compound_code"]
        globalCode <- map["global_code"]
    }
}
