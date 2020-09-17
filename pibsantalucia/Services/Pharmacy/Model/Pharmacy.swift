//
//  Pharmacy.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Pharmacy {
    var name: String
    var icon: String
    var address: String
    
    init(name: String, icon: String, address: String) {
        self.name = name
        self.icon = icon
        self.address = address
    }
}

extension Pharmacy {
    
    static func parse(json: [JSON]) -> [Pharmacy] {
        var listReturn: [Pharmacy] = []
        for item in json {
            let name    = item["name"].stringValue
            let icon    = item["icon"].stringValue
            let address = item["vicinity"].stringValue
            
            listReturn.append(self.init(name: name,
                                        icon: icon,
                                        address: address))
        }
        return listReturn
    }
}
