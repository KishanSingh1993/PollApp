//
//  PALogInVC.swift
//  PollApp
//
//  Created by Ankleshwar on 13/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import TextFieldEffects
import SVProgressHUD
import Crashlytics


class PALogInVC: BaseViewController {
    @IBOutlet weak var viewBackgound: UIView!
    
    @IBOutlet weak var txtPhone: HoshiTextField!
    @IBOutlet weak var viewLogin: UIView!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var viewSecond: UIView!
    
    var deviceToken : String!
    
    
    var strOTP : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView().setShadow(self.viewLogin)
      
        
        self.createGradientLayer(viewGradent: self.viewBackgound, color1: "#ba1db5",color2:"#460b64", alphaValue: 0.10)
        
        
   
        
    }
    
    override func viewDidLayoutSubviews() {
 
        self.createGradientLayer(viewGradent: self.viewBackgound, color1: "#ba1db5",color2:"#460b64", alphaValue: 0.10)
        self.btnNext.applyGradient(colours: [self.btnColor1,self.btnColor2])
        self.btnNext.layer.cornerRadius = 5.0;
        self.btnNext.layer.masksToBounds = true;
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.txtPhone.setNumberKeybord(self, withLeftTitle: "Cancel", andRightTitle: "Done")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    
    
    
    
    
    @IBAction func clickToNext(_ sender: Any) {
       
        if txtPhone.text?.count == 0 {
            ECSAlert().showAlert(message: "Please Enter Your Phone Number", controller: self)
        }
        else{
            
            let str = self.txtPhone.text! + "," + " " + "Is this correct or would you like  to change the phone number "
            
            let alertController = UIAlertController(title: "We will be verifing the phone number", message:str, preferredStyle:UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default)
            { action -> Void in
                
                
                self.callLogingServiec()
                
            })
            alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default)
            { action -> Void in
                
                
                // self.callLogingServiec()
                
            })
            self.present(alertController, animated: true, completion: nil)
            
            
            
            
            
            
        }
        
        
    }
    
    func getDeviceToken(token:String){
        print(token)
        self.deviceToken = token
    }
    
    func callLogingServiec(){
        
        SVProgressHUD.show()
//        guard let divecetoken = UserDefaults.standard.string(forKey: "deviceToken")else {
//            return
//        }
        
        let dic = ["mobileNumber": self.txtPhone.text ?? "",
                   "pushToken": UserDefaults.standard.string(forKey: "deviceToken") ?? "NotificationNotAllowed",
                   "deviceId":ECSHelper().getDeviceId()] as [String : Any]
        
        ServiceClass().getLoginDetails(strUrl:"login", param: dic) { error , dicData  in
            
            
            
            if error != nil {
                
                SVProgressHUD.dismiss()
                ECSAlert().showAlert(message:
                    (error?.localizedDescription)!, controller: self)
            }
            else{
                
                if dicData["status"] as! Int == 200 {
                    if let users = dicData["data"] as? [String : Any] {
                        self.strOTP = users["OTP"] as! String
                        let mobile  = users["mobileNumber"] as! String
                        print(self.strOTP)
                        let  viewController = PAOTPVC(nibName: "PAOTPVC", bundle: nil)
                        viewController.strPhone = mobile
                        self.navigationController?.pushViewController(viewController, animated: true)
                        
                        
                    }
                    SVProgressHUD.dismiss()
                    
                }
                else{
                    
                    if let users = dicData["errors"] as? [String : Any] {
                        if let mobile = users["mobileNumber"] as? [String : Any]{
                            
                            let msg = mobile["msg"] as! String
                            ECSAlert().showAlert(message: msg, controller: self)
                            
                        }
                    }
                    
                    SVProgressHUD.dismiss()
                    
                    
                    
                }
            }
            
            
            
            
        }
    }
    
    
    
}

extension PALogInVC: UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.moveTextField(textField: textField, moveDistance: -150, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.moveTextField(textField: textField, moveDistance: -150, up: false)
    }
    
}
