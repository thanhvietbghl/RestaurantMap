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
    
    func fetchMarkerSuccess() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.showMarker()
        }
    }
    
    func fetchCurrentPlaceSuccess(placesClient: GMSPlacesClient) {
    }
}
