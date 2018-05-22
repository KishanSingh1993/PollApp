//
//  PAOTPVC.swift
//  PollApp
//
//  Created by Ankleshwar on 13/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import TextFieldEffects
import SVProgressHUD


class PAOTPVC: BaseViewController {

    @IBOutlet weak var txtOtp: HoshiTextField!
    var strPhone : String!
    
    @IBOutlet weak var viewOtp: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

            UIView().setShadow(self.viewOtp)
      
    }

    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func clickToVerify(_ sender: Any) {
        
        callOtpServiec()
        
        
    }
    
    func callOtpServiec(){
        
        SVProgressHUD.show()
        
        
        let dic = ["OTP": self.txtOtp.text,
                   "mobileNumber": self.strPhone,
                   "pushToken":"fsafsafsafsadfdas",
                   "deviceId":ECSHelper().getDeviceId()] as [String : Any]
        
        ServiceClass().otpVerification(strUrl:"login", param: dic) { error , dicData  in
            
            if dicData["status"] as! Int == 200 {
 
                if let data = dicData["data"] as? [String : Any] {
                    if let user = data["user"] as? [String : Any] {
                        print(data["authToken"])
                        self.appUserObject = AppUserObject.instance(from: dicData)
                        self.appUserObject?.userId = user["userId"] as! String
                        self.appUserObject?.userName = user["name"] as! String
                        self.appUserObject?.access_token = data["authToken"] as! String
                        self.appUserObject?.device_id = user["deviceId"] as! String
                        
                        self.appUserObject?.saveToUserDefault()
                        let  viewController = PAProfile(nibName: "PAProfile", bundle: nil)
                        self.navigationController?.pushViewController(viewController, animated: true)
                        UserDefaults.standard.set(2, forKey: "isLogin")
                        UserDefaults.standard.synchronize()
                        
                    }
                   
                    
                    
                    
                }
                
                
                
                
              
                
                
                SVProgressHUD.dismiss()
                
            }
            else{
                    let msg = dicData["userMessage"] as! String
                     ECSAlert().showAlert(message: msg, controller: self)
                
                
                
                
                SVProgressHUD.dismiss()
                
                
                
            }
        }
   }
}

extension PAOTPVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.count == 4{
            return false
        }
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
}
