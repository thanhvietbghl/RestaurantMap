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
    
    fileprivate var interactor: HomeBusinessLogic!
    fileprivate var router: HomeRoutingLogic!
    
    var zoomLevel: Float = 17
    var locationManager = CLLocationManager()
    var camera = GMSCameraPosition()
    var currentLocation: CLLocation?
    var restaurantMarkers = [GMSMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogicLayers()
        setupMapView()
        setupLocationManager()
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
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    private func updateCamera(locationCoordinate: CLLocationCoordinate2D) {
        camera = GMSCameraPosition.camera(withLatitude: locationCoordinate.latitude,
                                          longitude: locationCoordinate.longitude,
                                          zoom: zoomLevel)
    }
    
    private func cleanMarker() {
        if mapView.isHidden {
          mapView.isHidden = false
          mapView.camera = camera
        } else {
          mapView.animate(to: camera)
        }
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
            let coordinate = CLLocationCoordinate2D(latitude: restaurant.geometry.location.lat, longitude: restaurant.geometry.location.lng)
            let marker = GMSMarker()
            marker.position = coordinate
            marker.icon = UIImage(named: "current_marker_icon")
            marker.title = restaurant.name
            marker.snippet = restaurant.plusCode.compoundCode
            marker.map = mapView
            self.restaurantMarkers.append(marker)
        }
    }
    
    deinit {
        cleanMarker()
    }
}

extension HomeViewController: HomeDisplayLogic {
    
    func displayRestaurantsNearbyLocation(_ restaurants: [Restaurant]) {
        self.setupMarkersForRestaurants(restaurants: restaurants)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last,
              (currentLocation?.distance(from: location) ?? 101) > 100
        else { return }
        currentLocation = location
        updateCamera(locationCoordinate: location.coordinate)
        cleanMarker()
        showMainMarker()
        fetchRestaurantsNearbyLocation(locationCoordinate: location.coordinate)
    }
}

extension HomeViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        updateCamera(locationCoordinate: coordinate)
        cleanMarker()
        showMainMarker()
        fetchRestaurantsNearbyLocation(locationCoordinate: coordinate)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.selectedMarker = marker
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        router.goToRestaurantDetail()
        mapView.selectedMarker = nil
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        zoomLevel = position.zoom
    }
}
