//
//  Category.swift
//  RestaurantMap
//
//  Created by Viet Phan on 08/04/2022.
//

import Foundation
import ObjectMapper

struct Category: Mappable {
    var alias: String
    var title: String

    init() {
        alias = ""
        title = ""
    }
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        alias <- map["alias"]
        title <- map["title"]
    }
}
