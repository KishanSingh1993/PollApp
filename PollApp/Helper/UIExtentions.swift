//
//  UIExtentions.swift
//  TestExtension
//
//  Created by Opiant on 26/12/17.
//  Copyright © 2017 Opiant. All rights reserved.
//

import Foundation
import UIKit

private var extensionGlobal: UIExtensions?

class UIExtensions: NSObject {
    var parentController: UIViewController?
    
    class var sharedInstance: UIExtensions! {
        if !(extensionGlobal != nil) {
            extensionGlobal = UIExtensions()
        }
        return extensionGlobal
    }

    


}


extension UIView {
    func addShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}



extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)

        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}


extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        

        
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        print("------size-----\(self.frame.size)")
        
        gradient.frame.size = self.bounds.size
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}
public extension Date {
    public  func ISOStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT") as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from:date)
    }
    
    var toDay : String
    {
        let date = Date()
        return ISOStringFromDate(date: date)
    }
    
//    func getDateFromeString(strDate:String) -> Date{
////        let dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
////
////        return dateFormatter.date(from: strDate)!
//    }
    
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


extension UITextField {
    

    
    

    //UIColor(red: 224.0 / 255.0, green: 225.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)

    func setNumberKeybordWithLeftTitle(_ `left`: String, andRightTitle `right`: String) {
        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        //toolBar.barStyle = UIBarStyleBlackOpaque;
        if Float(UIDevice.current.systemVersion) ?? 0.0 >= 7 {
            numberToolbar.barTintColor = UIColor(red: 224.0 / 255.0, green: 225.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
        }
        else {
            numberToolbar.tintColor = UIColor.black
        }
    numberToolbar.items = [UIBarButtonItem(title: `left`, style: .bordered, target: self, action: #selector(self.cancelNumberPad)), UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: `right`, style: .done, target: self, action: #selector(self.doneWithNumberPad))]
    numberToolbar.sizeToFit()
    inputAccessoryView = numberToolbar
    
    
    }
    
    public func setNumberKeybord(_ controller: UIViewController, withLeftTitle `left`: String, andRightTitle `right`: String) {
        UIExtensions.sharedInstance.parentController = controller
        setNumberKeybordWithLeftTitle(`left`, andRightTitle: `right`)
    }
    
    
    @objc func cancelNumberPad() {
                resignFirstResponder()
                text = ""
}
    @objc func doneWithNumberPad() {
        
        resignFirstResponder()
      
    }
    
 
  public  func isBlank() -> Bool {
        if text?.count == 0 {
            return true
        }
        return false
    }
        
 public   func setPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: frame.size.height))
        rightView = paddingViewRight
        rightViewMode = .always
    }

 public   func setLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    
  public  func setRightPadding() {
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: frame.size.height))
        rightView = paddingViewRight
        rightViewMode = .always
    }


    func isValidEmail() -> Bool {
        let stricterFilter = true
        if text?.count == 0 {
            return false
        }
        let stricterFilterString = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let laxString = ".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*"
        let emailRegex: String = stricterFilter ? stricterFilterString : laxString
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: text)
    }



}

extension UIPickerView {
    func setUpWithDoneButton() {
        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        numberToolbar.barStyle = .blackTranslucent
        numberToolbar.items = [UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelWithNumberPad)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneWithNumberPad))]
        numberToolbar.sizeToFit()
        numberToolbar.isUserInteractionEnabled = true
        addSubview(numberToolbar)
    }
    
    @objc func doneWithNumberPad(sender: Any) {
        superview?.removeFromSuperview()
    }
    
    @objc func cancelWithNumberPad(sender: Any){
        superview?.removeFromSuperview()
    
    }
}

    
    
extension UITextView {
    func setNumberKeybord() {
        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.size.width), height: 50))
        numberToolbar.barStyle = .blackTranslucent
        numberToolbar.items = [UIBarButtonItem(title: "Cancel", style: .bordered, target: self, action: #selector(self.cancelNumberPad)), UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneWithNumberPad))]
        numberToolbar.sizeToFit()
        inputAccessoryView = numberToolbar
    }
    
    @objc func cancelNumberPad() {
        resignFirstResponder()
        text = ""
    }
    
    @objc func doneWithNumberPad() {
        resignFirstResponder()
    }
}
    
    
extension NSDate {
    
    func getTimeFrom(dateFrom : Date , dateTo: Date) -> String {
        
       
        let difference = NSCalendar.current.dateComponents([.day, .hour, .minute, .second], from: dateTo)
        
        let seconds = "\(String(describing: difference.second))s"
        let minutes = "\(String(describing: difference.minute))m" + " " + seconds
        let hours = "\(String(describing: difference.hour))h" + " " + minutes
        let days = "\(String(describing: difference.day))d" + " " + hours
        
        if difference.day!    > 0 { return days }
        if difference.hour!   > 0 { return hours }
        if difference.minute! > 0 { return minutes }
        if difference.second! > 0 { return seconds }
        return ""
    }
    
   
    
}
    
    
    
    








public extension UIColor {
    
    public var hsbaComponents: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    

   
}


