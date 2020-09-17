//
//  PharmacyModel.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation

struct PharmacyModel {
    var name: String
    var icon: String
    var address: String
    
    init(name: String, icon: String, address: String) {
        self.name = name
        self.icon = icon
        self.address = address
    }
}
