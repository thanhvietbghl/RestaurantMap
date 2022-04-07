//
//  HomeInteraction.swift
//  RestaurantMap
//
//  Created by Viet Phan on 07/04/2022.
//

import Foundation
import GooglePlaces

class HomeInteraction: HomeBusinessLogic {
    
    weak var presenter: HomePresentationLogic?
    
    private var placesClient: GMSPlacesClient!
    
    func fetchMarker() {
    }
    
    func getCurrentPlace() {
    }
}
