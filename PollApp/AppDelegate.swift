//
//  AppDelegate.swift
//  PollApp
//
//  Created by Ankleshwar on 13/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
// 165934

import UIKit
import FBSDKLoginKit
import Fabric
import Crashlytics
import GooglePlacePicker
import GoogleMaps
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var viewController: UIViewController?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
   
//        
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { granted, err in
//            if  granted{
//                DispatchQueue.main.async {
//                    application.registerForRemoteNotifications()
//                }
//                
//               
//            }else{
//               // ECSAlert().showAlert(message: "User Notification permission denied :\(err?.localizedDescription)", controller: self)
//                
//                print("User Notification permission denied :\(String(describing: err?.localizedDescription))")
//            }
//        }
            Fabric.with([Crashlytics.self])
            setRootcontrooler()
        GMSPlacesClient.provideAPIKey(googleApi)
         return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
    }

    
    
    func setRootcontrooler(){
        
        let controllerVelue = UserDefaults.standard.integer(forKey: "isLogin")
        
        if controllerVelue == 3{
            viewController = PAHomeVC(nibName: "PAHomeVC", bundle: nil)
        }
        else{
            viewController = PALogInVC(nibName: "PALogInVC", bundle: nil)
        }
        window = UIWindow(frame: UIScreen.main.bounds)
      
        navigationController = UINavigationController(rootViewController: (viewController)!)
        self.window?.rootViewController = self.navigationController
        navigationController?.navigationBar.isHidden = true
        window?.makeKeyAndVisible()
        
        
    }
    
    func deviceString(_ deviceToken:Data) -> String{
        let bytes = [UInt8](deviceToken)
        var token = ""
        for byte in bytes{
            token += String(format:"%2x", byte)
        }
        return token
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken)
        print(deviceString(deviceToken))
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed register \(error.localizedDescription)")
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {
      
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
      
    }


}

