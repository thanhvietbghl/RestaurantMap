//
//  API_Restaurant.swift
//  RestaurantMap
//
//  Created by Viet Phan on 12/04/2022.
//

import Foundation
import RxSwift
import ObjectMapper

extension APIService {
    func getRestaurantsNearbyLocation(input: NearbyRestaurantsInput) -> Observable<RestaurantsNearbyOutput> {
        return request(input)
    }
}

class NearbyRestaurantsInput: APIBaseInput {
    init(latitude: Double,
         longitude: Double) {
        let location = "\(latitude),\(longitude)"
        let params = [
            "location": location,
            "radius": GoogleMaps.restaurantsNearbyRadius,
            "type": "restaurant",
            "key": APIConfig.googleMapAPIKey
        ] as [String : Any]
        super.init(urlString: APIURL.restaurants,
                   method: .get,
                   parameters: nil,
                   urlParams: params
        )
    }
}

class RestaurantsNearbyOutput: APIBaseOutput {

    var restaurants: [Restaurant]?

    override func mapping(map: Map) {
        super.mapping(map: map)
        restaurants <- map["results"]
    }
}
