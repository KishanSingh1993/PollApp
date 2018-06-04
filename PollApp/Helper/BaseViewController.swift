//
//  BaseViewController.swift
//  TestExtension
//
//  Created by Opiant on 27/12/17.
//  Copyright © 2017 Opiant. All rights reserved.
//

import UIKit
import CoreLocation



class BaseViewController: UIViewController {
    
    var screenWidth: Float = 0.0
    var screenHeight: Float = 0.0

    var appUserObject: AppUserObject?
    var appDelegate: AppDelegate?
    var gradientLayer: CAGradientLayer!
    var color1: UIColor!
    var color2: UIColor!
    
    var btnColor1: UIColor!
    var btnColor2: UIColor!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
         color1 = self.hexStringToUIColor(hex: "#ba1db5", alphaValue: 0.45)
        color2 = self.hexStringToUIColor(hex: "#460b64", alphaValue: 0.45)
        btnColor1 = self.hexStringToUIColor(hex: "#ffa200", alphaValue: 1)
        btnColor2 = self.hexStringToUIColor(hex: "#c28110", alphaValue: 1)
        
        screenWidth = Float(UIScreen.main.bounds.size.width)
        screenHeight = Float(UIScreen.main.bounds.size.height)
        
        appUserObject = AppUserObject.getFromUserDefault()
     //   appDelegate?.getLocation()
        
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        }
    
    func createGradientLayer(viewGradent:UIView,color1:String,color2:String,alphaValue:CGFloat) {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = viewGradent.frame
        
        let color1 = self.hexStringToUIColor(hex: color1, alphaValue: alphaValue)
        let color2 = self.hexStringToUIColor(hex: color2, alphaValue: alphaValue)
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        
        viewGradent.layer.addSublayer(gradientLayer)
    }
    
    func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }
    
    
    func moveTextField(textField: UITextField, moveDistance: Int , up: Bool){
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.beginAnimations("animationTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
    func setDataWithLocalJson(_ key: String) -> Array<Any> {
        let filePath: String? = Bundle.main.path(forResource: "LocalText", ofType: "json")
        let data = NSData(contentsOfFile: filePath ?? "") as Data?
        var error: Error? = nil
        let rootdic = (try? JSONSerialization.jsonObject(with: data ?? Data(), options: [])) as? [AnyHashable: Any]
        let arrMain = rootdic?[key] as? [Any]
       // print("\(arrMain)")
        return (arrMain as! NSArray) as! Array<Any>
    }
    
   // func checkLocationSetting() -> Bool {
        
    //    print(UserDefaults.standard.object(forKey: "HasLaunchedOnce"))
        
//        
//            if CLLocationManager.locationServicesEnabled() {
//                switch CLLocationManager.authorizationStatus() {
//                case .notDetermined, .restricted, .denied:
//                    //print("No access")
////                    let alert = UIAlertView(title: "Location Error!", message: "Location Access has been denied for VoyMate!", delegate: nil, cancelButtonTitle: "Ok")
//                    
//                    
//                    // alert.tag=500;
//                    alert.show()
//                    return false
//                case .authorizedAlways, .authorizedWhenInUse:
//                    print("Access")
//                    return true
//                    
//                }
//            } else {
//               // print("Location services are not enabled")
////                let alert = UIAlertView(title: "Location Error!", message: "Location services are not enabled!", delegate: nil, cancelButtonTitle: "Ok")
//                // alert.tag=500;
//                alert.show()
//                return false
//            }
 //       }
        
        

   public func isFirstTime(){
        if !UserDefaults.standard.bool(forKey: "HasLaunchedOnce") {
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
        }

    }
    
    
    
    
//    func settingTopView(_ view: UIView, on controller: UIViewController, andTitle title: String) {
//     //   let firstFrame = CGRect(x: 0, y: 0, width: Int(self.screenWidth), height: 46)
//       
//        topBar = (TopBar(controller: controller, withTitle: title) as? TopBar)!
//        view.addSubview((topBar?.view)!)
//    }
//    
//    func setTopView(_ view: UIView, on controller: UIViewController, andTitle headerTitle: String, withButton isVisible: Bool, withButtonTitle buttonTitle: String, withButtonImage buttonBackgroundImage: String, withoutBackButton isHidden: Bool) {
//        topBar = (TopBar(controller: controller, withTitle: headerTitle, withButton: isVisible, withButtonTitle: buttonTitle, withButtonImage: buttonBackgroundImage, withoutBackButton: isHidden) as? TopBar)!
//        view.addSubview((topBar?.view)!)
//    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
      
    }

    
    func hexStringToUIColor (hex:String , alphaValue: CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alphaValue)
        )
    }
    
}
