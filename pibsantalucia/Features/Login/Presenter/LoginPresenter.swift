//
//  LoginPresenter.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class LoginPresenter {
    
    fileprivate var service: LoginService
    fileprivate var view: LoginViewProtocol
    
    init(view: LoginViewProtocol) {
        self.view = view
        self.service = LoginService()
    }
}

extension LoginPresenter {
    
    func login(email: String, password: String) {
        // validação
        if (email.isEmpty && password.isEmpty) {
            self.view.error(message: "Todos os campos são obrigatórios.")
            return
        }
        
        service.login(email: email, password: password, success: { result in
            let userModel: UserModel = UserModel.init(id: result.id,
                                                      name: result.name,
                                                      photo: result.photo)
            
            self.view.success(user: userModel)
        }) { error in
            self.view.error(message: error.message)
        }
    }
}
