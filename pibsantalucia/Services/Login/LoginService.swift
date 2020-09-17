//
//  LoginService.swift
//  pibsantalucia

//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

final class LoginService {
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate

    func login(email: String, password: String, success: @escaping (User) -> Void, fail: @escaping (_ error: RequestError) -> Void) {
        let serviceUrl = appDelegate.environment.urlMain.appending("users/login")
        
        let parameters: [String : Any] = ["email": email,
                                          "senha": password]
        
        Request.sharedInstance.request(method: .post, url: serviceUrl, urlParameters: nil, headers: nil, parameters: parameters, success: { result in
            
            let json: [String: JSON] = JSON(result).dictionaryValue["object"]!.dictionaryValue
            success(User.parse(json: json))
        }) { error in
            fail(error)
        }
    }
}
