//
//  PAProfile.swift
//  PollApp
//
//  Created by Ankleshwar on 13/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import Contacts
import FBSDKCoreKit
import FBSDKLoginKit
import SVProgressHUD


class PAProfile: BaseViewController , FBSDKLoginButtonDelegate{
    @IBOutlet weak var viewSubGradinet: UIView!
    @IBOutlet var viewPersonal: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    var viewSubView: UIView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewFacebookProfile: UIView!
    
     @IBOutlet weak var viewCorporate: UIView!
    @IBOutlet weak var lblPersonal: UILabel!
    
    @IBOutlet weak var lblCorporates: UILabel!
    @IBOutlet weak var viewEvent: UIView!
    @IBOutlet weak var btnFacebookLogin: FBSDKLoginButton!
    
    @IBOutlet weak var lblEvent: UILabel!
    
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var viewMain: UIView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView().setShadow(viewMain)
        setShadow(viewPersonal)
        setShadow(viewCorporate)
        setShadow(viewEvent)
        self.imgUser.image = UIImage(named: "group_default_user.png");
        lblPersonal.numberOfLines = 0
        lblPersonal.text = "Personal\nProfile"
        lblCorporates.text = "Corporate\nProfile"
         lblEvent.text = "Event\nProfile"
      
       setView()
        self.btnFacebookLogin.readPermissions = ["public_profile", "email", "user_friends"]
        self.btnFacebookLogin.delegate = self
        
     //   self.btnFacebookLogin.addTarget(self, action: #selector(self.getFBUserData), for: .touchUpInside)
       
    }
    
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLayoutSubviews() {
        self.viewTop.applyGradient(colours: [self.color1,self.color2])
        print(self.viewPersonal.frame.size)
         print(self.viewPersonal.bounds.size)
      //  self.viewPersonal.applyGradient(colours: [self.btnColor1,self.btnColor2])
       // self.btnDone.applyGradient(colours: [self.btnColor1,self.btnColor2])
          self.viewFacebookProfile.frame =  CGRect(x: 10, y: 10, width: CGFloat(self.viewMain.frame.size.width-20), height:CGFloat(320))
    }

    @IBAction func clickToDone(_ sender: Any) {
        let vc = PAHomeVC(nibName: "PAHomeVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        UserDefaults.standard.set(3, forKey: "isLogin")
        UserDefaults.standard.synchronize()
    }
    
    func setShadow(_ view: UIView){
        
        
    
 
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 0.9568627451, green: 0.6196078431, blue: 0.007843137255, alpha: 1).cgColor
    }
    
    @IBAction func clickToCorporate(_ sender: Any) {
        let vc = Corporate(nibName: "Corporate", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBAction func clickToPersonal(_ sender: Any) {
        self.viewFacebookProfile.isHidden = false
        self.viewEvent.isHidden =  true
        self.viewCorporate.isHidden = true
        self.viewPersonal.isHidden = true
    }
    
    func setView(){
   
        UIView().setShadow(self.viewFacebookProfile)
        self.viewMain.addSubview(viewFacebookProfile)
 
        self.viewFacebookProfile.isHidden = true
    }
    
    
    @IBAction func clickToEvent(_ sender: Any) {
        let vc = PAEvent(nibName: "PAEvent", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        

}
    @IBAction func clickToRemoveFacebookView(_ sender: Any){
        
        self.viewFacebookProfile.isHidden = true
        self.viewEvent.isHidden =  false
        self.viewCorporate.isHidden = false
        self.viewPersonal.isHidden = false
    }
    
    @objc func getFBUserData(){
        
         print(self.btnFacebookLogin.tag)
        
        
//        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
//            fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
//                if (error == nil){
//                    let fbloginresult : FBSDKLoginManagerLoginResult = result!
//                    if fbloginresult.grantedPermissions != nil {
//                        if(fbloginresult.grantedPermissions.contains("email")) {
//                            if((FBSDKAccessToken.current()) != nil){
//                                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
//                                    if (error == nil){
//                                        let dict = result as! [String : AnyObject]
//                                        print(result!)
//                                        print(dict)
//                                    }
//                                })
//                            }
//                        }
//                    }
//                }
//                else{
//                    ECSAlert().showAlert(message: (error?.localizedDescription)!, controller: self)
//                }
//
//            }
        
        }

    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                returnUserData()
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print(error?.localizedDescription)
            }
            else
            {
                print("fetched user: \(result)")
                  let dict = result as! [String : AnyObject]
                let userName : NSString = dict["name"] as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = dict["email"] as! NSString
                print("User Email is: \(userEmail)")
                print(dict)
                self.callSocialScreenValue(name: userName as String, email: userEmail as String)
                
                
            }
        })
    }

    func callSocialScreenValue(name: String , email: String){
        SVProgressHUD.show()
        
        
        
        
        let dic = ["userId": (self.appUserObject?.userId)!,
                   "name": name,
                   "email":email,
                   "avatar":(self.appUserObject?.userImageUrl)!,
                   "source": (self.appUserObject?.source)!,
                   "deviceId": (self.appUserObject?.device_id)!,
                   "pushToken": (self.appUserObject?.token)!,
                   "mobileNumber":(self.appUserObject?.mobile)!,
                   "profileType":"0"] as [String : Any]
        
        
        
        
        ServiceClass().socialLogin(strUrl: "social/login", param: dic, header:(self.appUserObject?.access_token)!, completion: {err , dicData   in
            
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
                
                
 
                
                
                
                
                let alertController = UIAlertController(title: "", message: "user profile updated", preferredStyle:UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                { action -> Void in
                    
                    
                  
                    UserDefaults.standard.setValue(dicData , forKey: "socialProfile")
                    UserDefaults.standard.synchronize()
                    
                    UserDefaults.standard.set(3, forKey: "isLogin")
                    UserDefaults.standard.synchronize()
                    
                    let vc = PAHomeVC(nibName: "PAHomeVC", bundle: nil)
                    vc.isGroupCreate = false
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                })
                self.present(alertController, animated: true, completion: nil)
                
                
                
                SVProgressHUD.dismiss()
            }
            SVProgressHUD.dismiss()
            
        })
        
    }
    
}
