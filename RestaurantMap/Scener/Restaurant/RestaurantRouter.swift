//
//  RestaurantRouter.swift
//  RestaurantMap
//
//  Created by Viet Phan on 13/04/2022.
//

import Foundation
import UIKit

class RestaurantRouter: RestaurantRoutingLogics {
    
    weak var navigationController: UINavigationController?
    
    func callPhoneNumber(_ phoneNumber: String) {
        if let url = URL(string: "telprompt://\(phoneNumber)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func openWebsite(_ url: String) {
        if let url = URL(string: url),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
