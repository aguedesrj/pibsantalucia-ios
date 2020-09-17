//
//  Request.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation

final class Request {
    static let sharedInstance: RequestClientProtocol = AlamofireRequestClient()
}
