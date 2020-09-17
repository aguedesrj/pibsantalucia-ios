//
//  AlamofireRequestClient.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class AlamofireRequestClient: RequestClientProtocol {
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate

    func request(method: RequestHTTPMethod, url: String, urlParameters: [String : String]?, headers: [String : String]?, parameters: [String : Any]?, success: @escaping (Any) -> Void, failure: @escaping (RequestError) -> Void) {
        
        if Utils.isNotConnectedToNetwork() {
            failure(RequestError.init(code: 0,
                                      message: Utils.failureConnectedToNetwork))
            return
        }
        
        switch method {
        case .get:
            appDelegate.manager.request(url, method: .get, parameters: urlParameters ?? [:], encoding: URLEncoding.default,
                              headers: self.setServiceHeaders(with: headers))
                .responseJSON { response in
                    
                    switch response.result {
                    case .success:
                        if response.response?.statusCode == 200 {
                            success(response.value!)
                        } else {
                            let requestError: RequestError? = RequestError.parse(json: JSON(response.value!))
                            if (requestError != nil) {
                                failure(requestError!)
                            } else {
                                failure(RequestError.init(code: (response.response?.statusCode)!,
                                                          message: Utils.messageSystemUnavailable))
                            }
                        }
                    case .failure( _):
                        failure(RequestError.init(code: 0, message: Utils.messageSystemUnavailable))
                    }
            }
        case .post:
            appDelegate.manager.request(url, method: .post, parameters: parameters ?? [:], encoding: JSONEncoding.default,
                              headers: self.setServiceHeaders(with: headers))
                .responseJSON { response in
                    
                    switch response.result {
                    case .success:
                        if response.response?.statusCode == 200 {
                            success(response.value!)
                        } else {
                            let requestError: RequestError? = RequestError.parse(json: JSON(response.value!))
                            if (requestError != nil) {
                                failure(requestError!)
                            } else {
                                failure(RequestError.init(code: (response.response?.statusCode)!,
                                                          message: Utils.messageSystemUnavailable))
                            }
                        }
                    case .failure( _):
                        failure(RequestError.init(code: 0, message: Utils.messageSystemUnavailable))
                    }
            }
        }
    }
    
    private func setServiceHeaders(with headers:[String : String]?) -> [String : String]? {
        // incluir o parametros no header...

        return headers
    }
}
