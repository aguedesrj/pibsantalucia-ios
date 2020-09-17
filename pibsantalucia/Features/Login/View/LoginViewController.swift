//
//  LoginViewController.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    
    private var presenter: LoginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = LoginPresenter.init(view: self)
        
        layoutScreen()
    }

    @IBAction func pressButtonEntrar(_ sender: Any) {
        self.showLoading()
        
        presenter.login(email: txtEmail.text!,
                        password: txtPassword.text!)
    }
}

extension LoginViewController {
    
    fileprivate func layoutScreen() {
        
        labelEmail.textColor = Color.primary.value
        labelPassword.textColor = Color.primary.value
        Utils.layoutButton(button: buttonLogin)
    }
}

extension LoginViewController: LoginViewProtocol {
    
    func success(user: UserModel) {
        LoginRouter().showHome(at: self,
                               user: user)
    }
    
    func error(message: String) {
        self.showAlert(message: message)
    }
}
