//
//  APIUrl.swift
//  RestaurantMap
//
//  Created by Viet Phan on 12/04/2022.
//

import Foundation

class APIURL {
    
    private static let baseYelpURL = "https://api.yelp.com/v3/"
    
    static let restaurants = baseYelpURL + "businesses/search"
}
