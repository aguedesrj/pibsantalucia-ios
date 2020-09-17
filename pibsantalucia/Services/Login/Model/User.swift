//
//  User.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    var id: Int
    var name: String
    var photo: String
    
    init(id: Int, name: String, photo: String) {
        self.id = id
        self.name = name
        self.photo = photo
    }
}

extension User {
    static func parse(json: [String: JSON]) -> User {
        let id = json["id"]!.intValue
        let name = json["name"]!.stringValue
        let photo = json["photo"]!.stringValue
        
        return self.init(id: id, name: name, photo: photo)
    }
}
