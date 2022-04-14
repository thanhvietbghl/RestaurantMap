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
        let params: [String : Any] = [
            "latitude": latitude,
            "longitude": longitude,
            "radius": GoogleMaps.restaurantsNearbyRadius,
        ]
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
        restaurants <- map["businesses"]
    }
}
