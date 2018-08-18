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

    @IBOutlet weak var txtOtpFour: HoshiTextField!
    @IBOutlet weak var btnOtp: UIButton!
    
    @IBOutlet weak var viewGradent: UIView!
    @IBOutlet weak var txtOtpThree: HoshiTextField!
    @IBOutlet weak var txtOtpTwo: HoshiTextField!
    @IBOutlet weak var txtOtpOne: HoshiTextField!
    var strPhone : String!
    
    @IBOutlet weak var viewOtp: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

            UIView().setShadow(self.viewOtp)
      
        
        txtOtpOne.delegate = self
        txtOtpTwo.delegate = self
        txtOtpThree.delegate = self
        txtOtpFour.delegate = self

        

//        self.viewGradent.applyGradient(colours: [self.color1,self.color2])
//         self.btnOtp.applyGradient(colours: [self.btnColor1,self.btnColor2])
        
        
        txtOtpOne.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        txtOtpTwo.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        txtOtpThree.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        txtOtpFour.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        self.txtOtpOne.setNumberKeybord(self, withLeftTitle: "Cancel", andRightTitle: "Done")
        self.txtOtpTwo.setNumberKeybord(self, withLeftTitle: "Cancel", andRightTitle: "Done")
        self.txtOtpThree.setNumberKeybord(self, withLeftTitle: "Cancel", andRightTitle: "Done")
        self.txtOtpFour.setNumberKeybord(self, withLeftTitle: "Cancel", andRightTitle: "Done")
        
    }
    
    override func viewDidLayoutSubviews() {
        self.viewGradent.applyGradient(colours: [self.color1,self.color2])
        self.btnOtp.applyGradient(colours: [self.btnColor1,self.btnColor2])
        self.btnOtp.layer.cornerRadius = 5.0;
        self.btnOtp.layer.masksToBounds = true;
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    
    @objc func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        
        if (text?.utf16.count)! >= 1{
            switch textField{
            case txtOtpOne:
                txtOtpTwo.becomeFirstResponder()
            case txtOtpTwo:
                txtOtpThree.becomeFirstResponder()
            case txtOtpThree:
                txtOtpFour.becomeFirstResponder()
            case txtOtpFour:
                txtOtpFour.resignFirstResponder()
            default:
                break
            }
        }else{
            
        }
    }

    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func clickToVerify(_ sender: Any) {
        
        
        if txtOtpOne.text?.count == 0 {
            ECSAlert().showAlert(message: "Please Enter the OTP", controller: self)
            
        }else if  txtOtpTwo.text?.count == 0 {
            ECSAlert().showAlert(message: "Please Enter the OTP", controller: self)
            
        }
        else if  txtOtpThree.text?.count == 0 {
            ECSAlert().showAlert(message: "Please Enter the OTP", controller: self)
            
        }
        else if  txtOtpFour.text?.count == 0 {
            ECSAlert().showAlert(message: "Please Enter the OTP", controller: self)
            
        }
        else{
            callOtpServiec()
        }
        
        
        
    }
    
    func callOtpServiec(){
        
        let strValue = self.txtOtpOne.text! + self.txtOtpTwo.text! + self.txtOtpThree.text! + self.txtOtpFour.text!
        
        SVProgressHUD.show()
        
        
        let dic = ["OTP": strValue,
                   "mobileNumber": self.strPhone,
                   "pushToken":"fsafsafsafsadfdas",
                   "deviceId":ECSHelper().getDeviceId()] as [String : Any]
        
        ServiceClass().otpVerification(strUrl:"login", param: dic) { error , dicData  in
            
            if dicData["status"] as! Int == 200 {
 
                if let data = dicData["data"] as? [String : Any] {
                    if let user = data["user"] as? [String : Any] {
                       
                        self.appUserObject = AppUserObject.instance(from: dicData)
                        self.appUserObject?.userId = user["_id"] as! String
                        self.appUserObject?.userName = user["name"] as! String
                        self.appUserObject?.access_token = data["authToken"] as! String
                        self.appUserObject?.device_id = user["deviceId"] as! String
                        self.appUserObject?.email = user["email"] as! String
                        self.appUserObject?.source = "source"
                            //user["source"] as! String
                        self.appUserObject?.token = user["pushToken"] as! String
                        self.appUserObject?.userImageUrl = "avatar"
                            //user["avatar"] as! String
                        self.appUserObject?.mobile = user["mobileNumber"] as! String
                        let typeUser = user["profileType"] as! Int
                        self.appUserObject?.userType = String(typeUser)
                        let id = user["profileType"] as! Int
                        
                        
                        self.appUserObject?.profileId = String(id)
                        self.appUserObject?.saveToUserDefault()
                        
                         let isSetProfile = user["profileSetup"] as! Bool
                        
                        if isSetProfile == false{
                            let vc = PAProfile(nibName: "PAProfile", bundle: nil)
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        }else{
                            
                            if typeUser == 0  {
                                
                                if   let proficDic = data["user"]  {
                                    let vc = PAHomeVC(nibName: "PAHomeVC", bundle: nil)
                                    vc.isGroupCreate = false
                                    UserDefaults.standard.setValue(proficDic , forKey: "socialProfile")
                                    UserDefaults.standard.synchronize()
                                    self.navigationController?.pushViewController(vc, animated: true)
                                    UserDefaults.standard.set(3, forKey: "isLogin")
                                    UserDefaults.standard.synchronize()
                                }else{
                                    let vc = PAProfile(nibName: "PAProfile", bundle: nil)
                                    
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                
                                
                                
                                
                                
                            }else if typeUser == 1  {
                                
                                if   let proficDic = user["profile"]  {
                                    self.nextController(key: "corporateProfile", proficDic: proficDic as! [String : String])
                                }else{
                                    let vc = PAProfile(nibName: "PAProfile", bundle: nil)
                                    
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                
                                
                                
                                
                            }else if typeUser == 2  {
                                
                                if   let proficDic = user["profile"]  {
                                    self.nextController(key: "eventProfile", proficDic: proficDic as! [String : String])
                                }else{
                                    let vc = PAProfile(nibName: "PAProfile", bundle: nil)
                                    
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                
                                
                                
                                
                            }else{
                                let vc = PAProfile(nibName: "PAProfile", bundle: nil)
                                
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                            
                            
                        }
                 
                        
                        
                        
                        
                       
                   
                       
                    
                        
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
    
    func nextController(key :String ,proficDic: [String : String]){
        let vc = PAHomeVC(nibName: "PAHomeVC", bundle: nil)
        vc.isGroupCreate = false
        self.navigationController?.pushViewController(vc, animated: true)
        UserDefaults.standard.set(3, forKey: "isLogin")
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.setValue(proficDic, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
}

extension PAOTPVC: UITextFieldDelegate{
    

    

    
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
