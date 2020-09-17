//
//  AppDelegate.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import UIKit
import UserNotificationsUI
import Firebase
import UserNotifications
import Alamofire
import BackgroundTasks
import FirebaseMessaging
import FirebaseCrashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var manager: SessionManager!
    var environment: Environment!
    var navController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        
        self.navController = UINavigationController(rootViewController: initialViewController)

        #if DEBUG
            environment = Environment.debug
        #else
            environment = Environment.release
        #endif
        
        manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30 // em segundos
        manager.session.configuration.timeoutIntervalForResource = 30 // em segundos
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

