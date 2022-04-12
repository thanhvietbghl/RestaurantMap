//
//  HomeInteraction.swift
//  RestaurantMap
//
//  Created by Viet Phan on 07/04/2022.
//

import Foundation
import RxSwift

class HomeInteractor: HomeBusinessLogic {
   
    var presenter: HomePresentationLogic?
    
    private let repository = RestaurantRepository()
    let disposeBag = DisposeBag()
    
    func getRestaurantsNearbyLocation(latitude: Double, longitude: Double) {
        repository.getRestaurantsNearbyLocation(latitude: latitude, longitude: longitude)
            .subscribe(onNext: { [weak self] restaurants in
                guard let self = self else { return }
                self.presenter?.getRestaurantsNearbyLocationSuccess(restaurants)
            }).disposed(by: disposeBag)
    }
}
