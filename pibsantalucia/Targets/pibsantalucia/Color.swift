//
//  Color.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import UIKit

enum Color {
    case primary
    case primaryBold
    case blackWithAlpha16
    
    var value: UIColor {
        
        switch self {
            
            case .primary: return UIColor(red: 60.0/255.0,
                                          green: 180.0/255.0,
                                          blue: 231.0/255.0,
                                          alpha: 1.0)
            
            case .primaryBold: return UIColor(red: 32.0/255.0,
                                              green: 149.0/255.0,
                                              blue: 198.0/255.0,
                                              alpha: 1.0)
            
            case .blackWithAlpha16: return UIColor(red: 0/255,
                                                   green: 0/255,
                                                   blue: 0/255,
                                                   alpha: 0.16)
            
        }
    }
}
