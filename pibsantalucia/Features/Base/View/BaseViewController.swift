//
//  BaseViewController.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var progress: ProgressCustom!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showLoadingWithTextProgress(textProgress: String) {
        if self.progress == nil {
            self.progress = ProgressCustom(navigationController: appDelegate.navController!)
        }
        self.progress.text = textProgress
        self.progress.show()
    }
    
    func showLoading() {
        if self.progress == nil {
            self.progress = ProgressCustom(navigationController: appDelegate.navController!)
        }
        self.progress.show()
    }
    
    func hideLoading() {
        if self.progress != nil {
            self.progress.hide()
        }
    }
    
    func showAlert(message: String) {
        showAlert(withTitle: "", message: message, buttonTitle: "OK")
    }
    
    func showAlert(withTitle title: String, message: String, buttonTitle: String) {
        hideLoading()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
