//
//  HomeLogics.swift
//  RestaurantMap
//
//  Created by Viet Phan on 07/04/2022.
//

import Foundation
import GooglePlaces

// MARK: Display logic
protocol HomeDisplayLogic: BusinessLogic {
    func displayRestaurantsNearbyLocation(_ restaurants: [Restaurant])
}

// MARK: BusinessLogic
protocol HomeBusinessLogic: BusinessLogic {
    var presenter: HomePresentationLogic? { get set }
    
    func getRestaurantsNearbyLocation(latitude: Double, longitude: Double)
}

// MARK: Presenter logic
protocol HomePresentationLogic: PresentationLogic {
    var view: HomeDisplayLogic? { get set }
    var router: HomeRoutingLogic? { get set }
    
    func getRestaurantsNearbyLocationSuccess(_ restaurants: [Restaurant])
}

// MARK: Routing logic
protocol HomeRoutingLogic: RoutingLogic {
    func goToRestaurantDetail(restaurant: Restaurant)
}
