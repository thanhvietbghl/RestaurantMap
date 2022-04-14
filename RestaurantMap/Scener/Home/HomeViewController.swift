//
//  HomeViewController.swift
//  RestaurantMap
//
//  Created by Viet Phan on 06/04/2022.
//

import UIKit
import GoogleMaps
import GooglePlaces

class HomeViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    private var interactor: HomeBusinessLogic!
    private var router: HomeRoutingLogic!
    private var restaurants: [Restaurant] = []
    
    var zoomLevel: Float = 18
    var camera = GMSCameraPosition()
    var restaurantMarkers = [GMSMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogicLayers()
        setupMapView()
        setupLocationDefault()
        fetchRestaurantsNearbyLocation(locationCoordinate: GoogleMaps.defaultLocation.coordinate)
    }
    
    func setupLogicLayers() {
        router = HomeRouter()
        router?.navigationController = self.navigationController
        interactor = HomeInteractor()
        let presenter = HomePresenter()
        presenter.view = self
        presenter.router = router
        interactor.presenter = presenter
    }
    
    private func setupMapView() {
        self.mapView.delegate = self
        do {
            guard let styleURL = Bundle.main.url(forResource: "StyleGoogleMap", withExtension: "json")
            else {
                 print("Unable to find style.json")
                return
              }
            self.mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
           } catch {
               print("One or more of the map styles failed to load. \(error)")
          }
    }
    
    private func updateCamera(locationCoordinate: CLLocationCoordinate2D) {
        camera = GMSCameraPosition.camera(withLatitude: locationCoordinate.latitude,
                                          longitude: locationCoordinate.longitude,
                                          zoom: zoomLevel)
        if mapView.isHidden {
          mapView.isHidden = false
          mapView.camera = camera
        } else {
          mapView.animate(to: camera)
        }
    }
    
    private func clearMapView() {
        mapView.clear()
        restaurantMarkers.forEach({ $0.map = nil })
    }
    
    private func showMainMarker() {
        let marker = GMSMarker()
        marker.position = camera.target
        marker.map = mapView
        mapView.selectedMarker = marker
    }
    
    private func fetchRestaurantsNearbyLocation(locationCoordinate: CLLocationCoordinate2D) {
        interactor.getRestaurantsNearbyLocation(latitude: locationCoordinate.latitude,
                                               longitude: locationCoordinate.longitude)
    }
    
    private func setupMarkersForRestaurants(restaurants: [Restaurant]) {
        restaurantMarkers.forEach({ $0.map = nil })
        restaurantMarkers.removeAll()
        for restaurant in restaurants {
            let coordinate = CLLocationCoordinate2D(latitude: restaurant.coordinates.latitude, longitude: restaurant.coordinates.longitude)
            let marker = GMSMarker()
            marker.position = coordinate
            marker.icon = UIImage(named: "restaurant_marker_icon")
            marker.title = restaurant.name
            marker.snippet = restaurant.location.address
            marker.map = mapView
            self.restaurantMarkers.append(marker)
        }
    }
    
    private func setupLocationDefault() {
        updateCamera(locationCoordinate: GoogleMaps.defaultLocation.coordinate)
        clearMapView()
        showMainMarker()
    }
    
    deinit {
        clearMapView()
    }
}

// add comment mark ....
extension HomeViewController: HomeDisplayLogic {
    
    func displayRestaurantsNearbyLocation(_ restaurants: [Restaurant]) {
        self.setupMarkersForRestaurants(restaurants: restaurants)
        self.restaurants = restaurants
    }
}

extension HomeViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        updateCamera(locationCoordinate: coordinate)
        clearMapView()
        showMainMarker()
        fetchRestaurantsNearbyLocation(locationCoordinate: coordinate)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.selectedMarker = marker
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        guard let restaurant = self.restaurants.first(where: {
            $0.coordinates.latitude == marker.position.latitude &&
            $0.coordinates.longitude == marker.position.longitude })
        else { return }
        router.goToRestaurantDetail(restaurant: restaurant)
        mapView.selectedMarker = nil
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        zoomLevel = position.zoom
    }
}
