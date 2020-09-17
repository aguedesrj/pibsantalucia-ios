//
//  HomePresenter.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class HomePresenter {
    
    fileprivate var service: PharmacyService!
    fileprivate var view: HomeViewProtocol!
    
    init(view: HomeViewProtocol) {
        self.view = view
        self.service = PharmacyService()
    }
}

extension HomePresenter {
    
    func nearestPharmacies(latitude: Double, longitude: Double) {
        service.nearestPharmacies(latitude: latitude, longitude: longitude, success: { result in
            
            var listPharmacy: [PharmacyModel] = []
            for pharmacy in result {
                
                listPharmacy.append(PharmacyModel.init(name: pharmacy.name,
                                                       icon: pharmacy.icon,
                                                       address: pharmacy.address))
            }
            
            self.view.success(listPharmacy: listPharmacy)
        }) { error in
            self.view.error(message: error.message)
        }
    }
}
