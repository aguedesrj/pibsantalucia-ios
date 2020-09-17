//
//  HomeViewProtocol.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation

protocol HomeViewProtocol {
    func success(listPharmacy: [PharmacyModel])
    func error(message: String)
}
