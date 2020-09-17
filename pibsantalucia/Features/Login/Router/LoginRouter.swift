//
//  LoginRouter.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import UIKit

final class LoginRouter {
    
    func showHome(at controller: UIViewController,
                   user: UserModel) {
        
        let viewController: HomeViewController =
            HomeViewController(nibName: "HomeViewController",
                               bundle: nil)
        viewController.user = user
        
        controller.show(viewController, sender: nil)
    }
}
