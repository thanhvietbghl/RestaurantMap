//
//  RestaurantViewController.swift
//  RestaurantMap
//
//  Created by Viet Phan on 13/04/2022.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var reviewCountLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    private var router: RestaurantRoutingLogics?
    private var interactor: RestaurantBusinessLogics?
    
    var restaurant: Restaurant?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogicLayers()
        setupUI()
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

    private func setupUI() {
        guard let restaurant = restaurant else { return }
        nameLabel.text = restaurant.name
        rateLabel.text = restaurant.starsDisplay
        reviewCountLabel.text = String(restaurant.reviewCount)
        priceLabel.text = restaurant.price
        addressLabel.text = restaurant.location.fullAddress
        imageView.setImage(url: restaurant.imageURL, placeholderImageName: "placeholder_icon")
    }
    
    @IBAction private func didTapCall(_ sender: Any) {
        guard let phone = restaurant?.phone else { return }
        router?.callPhoneNumber(phone)
    }
    
    @IBAction private func didTapWebsite(_ sender: Any) {
        guard let url = restaurant?.url else { return }
        router?.openWebsite(url)
    }
}

extension RestaurantViewController: RestaurantDisplayLogic {
}
