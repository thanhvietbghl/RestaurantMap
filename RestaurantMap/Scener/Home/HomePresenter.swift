//
//  HomePresenter.swift
//  RestaurantMap
//
//  Created by Viet Phan on 07/04/2022.
//

import Foundation
import GooglePlaces

class HomePresenter: HomePresentationLogic {
  
    weak var view: HomeDisplayLogic?
    weak var router: HomeRoutingLogic?
    
    func getRestaurantsNearbyLocationSuccess(_ restaurants: [Restaurant]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.displayRestaurantsNearbyLocation(restaurants)
        }
    }
}
