//
//  Corporate.swift
//  PollApp
//
//  Created by Ankleshwar on 31/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//
    
import UIKit
import SVProgressHUD

class Corporate: BaseViewController {
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtPersonName: UITextField!
    @IBOutlet weak var txtCompanyAddress: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtCompanyWebsite: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var topView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSubmit.layer.cornerRadius = 5.0
        
        let corporateProfile = UserDefaults.standard.dictionary(forKey: "corporateProfile")
        if corporateProfile != nil {
            print(corporateProfile)
            
            self.txtCompanyName.text = corporateProfile?["company_name"] as! String
             self.txtPersonName.text = corporateProfile?["company_contact_person"]as! String
             self.txtCompanyAddress.text = corporateProfile?["company_address"]as! String
             self.txtPhoneNumber.text = corporateProfile?["company_phone_number"]as! String
             self.txtEmailAddress.text = corporateProfile?["company_email_address"] as! String
             self.txtCompanyWebsite.text = corporateProfile?["company_website"] as! String
        }
        else{
            print("Nill")
        }
         self.txtPhoneNumber.setNumberKeybord(self, withLeftTitle: "Cancel", andRightTitle: "Done")
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        self.topView.applyGradient(colours: [self.color1,self.color2])
       self.btnSubmit.applyGradient(colours: [self.btnColor1,self.btnColor2])
        
    }

    @IBAction func clickToSubmit(_ sender: Any) {
        callCorporateScreenValue()
    }
    
    
    
    
    
    func callCorporateScreenValue(){
        SVProgressHUD.show()
        
        
        
        
        let dic = ["userId": self.appUserObject?.userId,
                   "profile": [
                    "company_name": self.txtCompanyName.text,
                    "company_contact_person": self.txtPersonName.text,
                    "company_address":self.txtCompanyAddress.text,
                    "company_phone_number":self.txtPhoneNumber.text,
                    "company_email_address":self.txtEmailAddress.text,
                    "company_website":self.txtCompanyWebsite.text,
                    
            ],
                   "profileType":"1"] as [String : Any]
        
        
        
        
        ServiceClass().getProfileEventDetails(strUrl: "profile", param: dic, header:(self.appUserObject?.access_token)!, completion: {err , dicData   in
            
            if(err != nil){
                
                
                
                
                
                let alertController = UIAlertController(title: "", message: (err?.localizedDescription)!, preferredStyle:UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                { action -> Void in
                    
                    if "Your session has been expired. Please relogin.".isEqualToString(find: (err?.localizedDescription)!){
                        
                        UserDefaults.standard.set(1, forKey: "isLogin")
                        UserDefaults.standard.synchronize()
                        let delegate = UIApplication.shared.delegate as! AppDelegate
                        delegate.setRootcontrooler()
                        
                    }
                    
                    
                })
                self.present(alertController, animated: true, completion: nil)
                
                
                
                
                
                
                SVProgressHUD.dismiss()
                
            }
            else{
                
                print(dicData)
                 ECSAlert().showAlert(message: "user profile updated", controller: self)
                let proficDic = dicData["profile"] as! [String : String]
                UserDefaults.standard.setValue(proficDic, forKey: "corporateProfile")
                UserDefaults.standard.synchronize()
                
                SVProgressHUD.dismiss()
            }
            SVProgressHUD.dismiss()
            
        })
        
    }
}
extension Corporate: UITextFieldDelegate{
    
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setLeftPaddingPoints(10)
        self.moveTextField(textField: textField, moveDistance: -150, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.moveTextField(textField: textField, moveDistance: -150, up: false)
    }
    
    
}
