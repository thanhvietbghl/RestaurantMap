//
//  RestaurantViewController.swift
//  RestaurantMap
//
//  Created by Viet Phan on 13/04/2022.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    private var router: RestaurantRoutingLogics?
    private var interactor: RestaurantBusinessLogics?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupLogicLayers() {
        router = RestaurantRouter()
        router?.navigationController = self.navigationController
        interactor = RestaurantInteractor()
        let presenter = RestaurantPresenter()
        presenter.view = self
        presenter.router = router
        interactor?.presenter = presenter
    }
}

extension RestaurantViewController: RestaurantDisplayLogic {
    
}
