//
//  Restaurant.swift
//  RestaurantMap
//
//  Created by Viet Phan on 14/04/2022.
//

import Foundation
import ObjectMapper

struct Restaurant: Mappable {
    
    var id: String
    var alias: String
    var name: String
    var imagePath: String
    var isClosed: Bool
    var url: String
    var phone: String
    var displayPhone: String
    var reviewCount: Int
    var categories: [Category]
    var rating: Int
    var location: Location
    var coordinates: Coordinates
    var photos: [String]
    var price: String
    
    var starsDisplay: String {
        var starsDisplay = ""
        for _ in 1...rating {
            starsDisplay.append("★")
        }
        return starsDisplay
    }
    
    var imageURL: URL? {
        return URL(string: imagePath)
    }
    
    init() {
        id = ""
        alias = ""
        name = ""
        imagePath = ""
        isClosed = false
        url = ""
        phone = ""
        displayPhone = ""
        reviewCount = 0
        categories = []
        rating = 0
        location = Location()
        coordinates = Coordinates()
        photos = []
        price = ""
    }
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        alias <- map["alias"]
        name <- map["name"]
        imagePath <- map["image_url"]
        isClosed <- map["is_closed"]
        url <- map["url"]
        phone <- map["phone"]
        displayPhone <- map["display_phone"]
        reviewCount <- map["review_count"]
        categories <- map["categories"]
        rating <- map["rating"]
        location <- map["location"]
        coordinates <- map["coordinates"]
        photos <- map["photos"]
        price <- map["price"]
    }
}
