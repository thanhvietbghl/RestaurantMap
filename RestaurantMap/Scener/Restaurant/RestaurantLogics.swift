//
//  RestaurantLogics.swift
//  RestaurantMap
//
//  Created by Viet Phan on 13/04/2022.
//

import Foundation

// MARK: Display logic
protocol RestaurantDisplayLogic: DisplayLogic {
}

// MARK: BusinessLogic
protocol RestaurantBusinessLogics: BusinessLogic {
    var presenter: RestaurantPresentationLogics? { get set }
}

// MARK: PresenterLogic
protocol RestaurantPresentationLogics: PresentationLogic {
    var view: RestaurantDisplayLogic? { get set }
    var router: RestaurantRoutingLogics? { get set }
}

// MARK: Routing logic
protocol RestaurantRoutingLogics: RoutingLogic {
}
