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

extension UIButton {
    public func makeCircular() {
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
    }
    public func setButtonImage(_ imageName: String) {
        setImage(UIImage(named: imageName), for: .normal)
    }
    
    public func setAttributedButtonTitle(_ title: NSAttributedString) {
        setAttributedTitle(title, for: .normal)
    }
    public func setButtonTitleColor(_ color: UIColor) {
        setTitleColor(color, for: .normal)
    }
    
    public func setButtonBackgroudImage(_ imageName: String) {
        setBackgroundImage(UIImage(named: imageName), for: .normal)
    }
    
    public func setButtonBackgroundColor(_ color: UIColor) {
        backgroundColor = color
    }
    public func setButtonTitle(_ title: String) {
        setTitle(title, for: .normal)
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
