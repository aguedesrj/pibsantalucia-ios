//
//  RequestClientProtocol.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestClientProtocol {
    func request(method: RequestHTTPMethod,
                 url: String,
                 urlParameters: [String : String]?,
                 headers: [String : String]?,
                 parameters: [String : Any]?,
                 success: @escaping (Any) -> Void,
                 failure: @escaping (RequestError) -> Void)
}
