//
//  UserModel.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation

struct UserModel {
    var id: Int
    var name: String
    var photo: String
    
    init(id: Int, name: String, photo: String) {
        self.id = id
        self.name = name
        self.photo = photo
    }
}
