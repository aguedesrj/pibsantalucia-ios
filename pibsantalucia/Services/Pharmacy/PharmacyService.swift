//
//  PharmacyService.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

final class PharmacyService {
    fileprivate let appDelegate = UIApplication.shared.delegate as! AppDelegate

    func nearestPharmacies(latitude: Double, longitude: Double, success: @escaping ([Pharmacy]) -> Void, fail: @escaping (_ error: RequestError) -> Void) {
        
        let serviceUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=2000&types=pharmacy&sensor=true&key=AIzaSyCaYp2hnHUf7OEO1DMe_HyE5YAjNH97B3M"
        
        Request.sharedInstance.request(method: .get, url: serviceUrl, urlParameters: nil, headers: nil, parameters: nil, success: { result in
            
            let json: [JSON] = JSON(result).dictionaryValue["results"]!.arrayValue
            success(Pharmacy.parse(json: json))
        }) { error in
            fail(error)
        }
    }
}
