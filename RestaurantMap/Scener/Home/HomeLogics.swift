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
    func showMarker()
}

// MARK: BusinessLogic
protocol HomeBusinessLogic: BusinessLogic {
    var presenter: HomePresentationLogic? { get set }
    func fetchMarker()
}

// MARK: Presenter logic
protocol HomePresentationLogic: PresentationLogic {
    var view: HomeDisplayLogic? { get set }
    var router: HomeRoutingLogic? { get set }
    
    func fetchMarkerSuccess()
    func fetchCurrentPlaceSuccess(placesClient: GMSPlacesClient)
}

// MARK: Routing logic
protocol HomeRoutingLogic: RoutingLogic {
    func showRestaurantDetail()
}
