//
//  AppDelegate.swift
//  RestaurantMap
//
//  Created by Viet Phan on 06/04/2022.
//

import UIKit
import GoogleMaps
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupGoogleMap()
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let homeVC = HomeViewController()
        window.rootViewController = UINavigationController(rootViewController: homeVC)
        window.makeKeyAndVisible()
        return true
    }
    
    private func setupGoogleMap() {
        GMSServices.provideAPIKey(APIConfig.googleMapAPIKey)
        GMSPlacesClient.provideAPIKey(APIConfig.googleMapAPIKey)
    }
}

