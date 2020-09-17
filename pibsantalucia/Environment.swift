//
//  Environment.swift
//  pibsantalucia
//
//  Created by André Lessa Guedes on 17/09/20.
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation

enum Environment {
    
    case release
    case debug
    
    var urlMain: String {
        switch self {
        case .release: return "https://pibsantalucia.getsandbox.com:443/"
        case .debug:   return "https://pibsantalucia.getsandbox.com:443/"
        }
    }
}
