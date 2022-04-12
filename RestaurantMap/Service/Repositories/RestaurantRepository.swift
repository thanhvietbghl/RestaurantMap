//
//  RestaurantRepository.swift
//  RestaurantMap
//
//  Created by Viet Phan on 12/04/2022.
//

import Foundation
import RxSwift

class RestaurantRepository {
    
    func getRestaurantsNearbyLocation(latitude: Double, longitude: Double) -> Observable<[Restaurant]> {
        let input = NearbyRestaurantsInput(latitude: latitude, longitude: longitude)
        return APIService.shared.getRestaurantsNearbyLocation(input: input)
            .map { output -> [Restaurant] in
                if let restaurants = output.restaurants {
                    return restaurants
                }
                throw APIResponseError.message(output.message)
        }
    }
}
