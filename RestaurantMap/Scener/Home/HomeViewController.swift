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

    private var interactor: HomeBusinessLogic?
    private var router: HomeRoutingLogic?
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupLogicLayers() {
        interactor = HomeInteraction()
        router = HomeRouter()
        let presenter = HomePresenter()
        presenter.view = self
        presenter.router = router
        interactor?.presenter = presenter
        router?.navigationController = self.navigationController
    }
}

extension HomeViewController: HomeDisplayLogic {
    
    func showMarker() {
    }
}
