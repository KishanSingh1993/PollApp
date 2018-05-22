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



class PALogInVC: UIViewController {

    @IBOutlet weak var txtPhone: HoshiTextField!
    @IBOutlet weak var viewLogin: UIView!
    
    var strOTP : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIView().setShadow(self.viewLogin)
        
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
            
            callLogingServiec()

        }
        
      
    }
    
    func callLogingServiec(){
        
        SVProgressHUD.show()
        
        
        let dic = ["mobileNumber": self.txtPhone.text,
                   "pushToken":"fsafsafsafsadfdas",
                   "deviceId":ECSHelper().getDeviceId()] as [String : Any]
        
        ServiceClass().getLoginDetails(strUrl:"login", param: dic) { error , dicData  in
            
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

extension PALogInVC: UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
}
