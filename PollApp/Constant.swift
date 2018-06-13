//
//  Constant.swift
//  PollApp
//
//  Created by Ankleshwar on 13/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import Foundation
import UIKit





   public extension UIView {
        
        
        func dropShadow(scale: Bool = true) {
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.7
            layer.shadowOffset = CGSize(width: -1, height: 1)
            layer.shadowRadius = 2
            layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            layer.shouldRasterize = true
            layer.rasterizationScale = scale ? UIScreen.main.scale : 1
            layer.cornerRadius = 20
        }
        
    func setShadow(_ view: UIView){
        
      view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 5
        layer.cornerRadius = 5
    }
}
extension String {
    func isEqualToString(find: String) -> Bool {
        return String(format: self) == find
    }
}


extension UIColor{
    
    func myHexStringToUIColor (_ hex:String) -> UIColor {
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
            alpha: CGFloat(1.0)
        )
    }
    
    

        convenience init(red: Int, green: Int, blue: Int) {
            assert(red >= 0 && red <= 255, "Invalid red component")
            assert(green >= 0 && green <= 255, "Invalid green component")
            assert(blue >= 0 && blue <= 255, "Invalid blue component")
            
            self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
        }
        
        convenience init(rgb: Int) {
            self.init(
                red: (rgb >> 16) & 0xFF,
                green: (rgb >> 8) & 0xFF,
                blue: rgb & 0xFF
            )
        }
    
}




 Search Api
 
 1. survey?search= "text"
 
 
 2. social/login
 
 Request :
 
 
 {
 
     "userId":"",
 
     "name":"",
 
     "email":"",
 
     "avatar":"",
 
     "source":"",
 
     "deviceId":"",
 
     "pushToken":"",
 
     "mobileNumber":""
 
 }
 
 
 3. Remove Group Member
 
 groups/{groupId}/member?userId="ID TO REMOVE"
 
 replace groupId with actual groupId and send userId in the query
 
 
 4. Get survey by id
 
 surveys/{surveyId}/details
 
 replace surveyId by acutal survey id
 
