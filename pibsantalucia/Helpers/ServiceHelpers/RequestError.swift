//
//  RequestError.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation
import SwiftyJSON

struct RequestError {
    var code: Int
    var message: String
    
    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}

extension RequestError {
    
    static func parse(json: JSON?) -> RequestError? {
        // verifica se retornou um JSON de erro.
        if (json?.dictionaryValue != nil && json?["status"] != JSON.null && json?["msg"] != JSON.null) {
            return self.init(code: (json!["status"].intValue), message: (json!["msg"].stringValue))
        }
        return nil
    }
}
