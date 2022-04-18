//
//  HomeRouter.swift
//  RestaurantMap
//
//  Created by Viet Phan on 07/04/2022.
//

import Foundation
import UIKit

class HomeRouter: HomeRoutingLogic {
    
    weak var navigationController: UINavigationController?
    
    func goToRestaurantDetail(restaurant: Restaurant) {
        let restaurantVC = RestaurantViewController()
        restaurantVC.restaurant = restaurant
        navigationController?.present(restaurantVC, animated: true)
    }
}
