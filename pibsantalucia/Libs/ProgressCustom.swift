//
//  ProgressCustom.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation
import MBProgressHUD

class ProgressCustom: NSObject {
    
    var mbProgressHud: MBProgressHUD!
    var navigationController: UINavigationController!
    var viewController: UIViewController!
    var text: String = "Carregando..."
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        
        self.mbProgressHud = MBProgressHUD(view: self.viewController.view)
        self.viewController.view.addSubview(self.mbProgressHud)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        self.mbProgressHud = MBProgressHUD(view: self.navigationController.view)
        self.navigationController.view.addSubview(self.mbProgressHud)
    }
    init(navigationController: UINavigationController, removeFromSuperViewOnHide: Bool = false) {
        self.navigationController = navigationController
        
        self.mbProgressHud = MBProgressHUD(view: self.navigationController.view)
        self.mbProgressHud.removeFromSuperViewOnHide = removeFromSuperViewOnHide
        self.navigationController.view.addSubview(self.mbProgressHud)
    }
}

extension ProgressCustom {
    
    func show() {
        self.mbProgressHud.isUserInteractionEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.mbProgressHud.label.text = text
        self.mbProgressHud.label.numberOfLines = 0
        self.mbProgressHud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
        self.mbProgressHud.bezelView.color = UIColor.white
        self.mbProgressHud.backgroundView.color = Color.primary.value
        self.mbProgressHud.show(animated: true)
    }
    
    func showWithInteraction() {
        self.mbProgressHud.isUserInteractionEnabled = false
        self.mbProgressHud.label.text = text
        self.mbProgressHud.label.numberOfLines = 0
        self.mbProgressHud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
        self.mbProgressHud.bezelView.color = UIColor.white
        self.mbProgressHud.show(animated: true)
    }
    
    func hide() {
        if (viewController == nil) {
             self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        self.mbProgressHud.hide(animated: true)
    }
    
    func isHide() -> Bool {
        return self.mbProgressHud.alpha == 0
    }
    
}
