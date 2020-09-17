//
//  LoginViewProtocol.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation


protocol LoginViewProtocol {
    func success(user: UserModel)
    func error(message: String)
}
