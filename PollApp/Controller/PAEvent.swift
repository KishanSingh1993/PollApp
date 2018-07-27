//
//  Corporate.swift
//  PollApp
//
//  Created by Ankleshwar on 31/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//
    
import UIKit
import SVProgressHUD


class PAEvent: BaseViewController {
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var txtDateEvent: UITextField!
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var txtEventName: UITextField!
    @IBOutlet weak var txtEventDate: UITextField!
    @IBOutlet weak var txtEventTittel: UITextField!
    @IBOutlet weak var txtContactEmailAddress: UITextField!
    @IBOutlet weak var txtEventDuration: UITextField!
    @IBOutlet weak var txtContactPersonPhone: UITextField!
    @IBOutlet weak var txtContactPersonName: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSubmit.layer.cornerRadius = 5.0
         let eventProfile = UserDefaults.standard.dictionary(forKey: "eventProfile")
        
        if eventProfile != nil {
            print(eventProfile)
            
            self.txtEventName.text = eventProfile?["event_name"] as! String
            self.txtEventDate.text = eventProfile?["event_date"]as! String
            self.txtEventTittel.text = eventProfile?["event_title"]as! String
            self.txtContactEmailAddress.text = eventProfile?["contact_person_email"]as! String
            self.txtEventDuration.text = eventProfile?["event_duration"] as! String
            self.txtContactPersonPhone.text = eventProfile?["contact_person_mobile"] as! String
            self.txtContactPersonName.text = eventProfile?["contact_person"] as! String
        }
        else{
           print("Nill")
        }
         self.txtContactPersonPhone.setNumberKeybord(self, withLeftTitle: "Cancel", andRightTitle: "Done")
        self.txtEventDuration.setNumberKeybord(self, withLeftTitle: "Cancel", andRightTitle: "Done")
       
        
         datePicker.translatesAutoresizingMaskIntoConstraints = false
    }   
    override func viewWillAppear(_ animated: Bool) {
        showDatePicker()
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
        callEventScreenValue()
    }
    
    
    
    func showDatePicker(){
        //Formate Date
//        self.datePicker.frame = CGRect(x: 0, y: CGFloat(self.screenHeight-250), width: CGFloat(self.screenWidth), height: 250)
//        self.datePicker.datePickerMode = .date
//
//        //ToolBar
//        let toolbar = UIToolbar();
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
//
//        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
//
//        txtDateEvent.inputAccessoryView = toolbar
        
        txtDateEvent.inputView = self.datePicker
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.donedatePicker))
        
        txtDateEvent.inputAccessoryView = toolBar
        
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtDateEvent.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    

    func callEventScreenValue(){
        SVProgressHUD.show()
        
        
        
        
        let dic = ["userId": self.appUserObject?.userId,
                   "profile": [
                    "event_name": self.txtEventName.text,
                    "event_date": self.txtEventDate.text,
                    "event_title":self.txtEventTittel.text,
                    "contact_person":self.txtContactPersonName.text,
                    "contact_person_mobile":self.txtContactPersonPhone.text,
                    "contact_person_email":self.txtContactEmailAddress.text,
                    "event_duration":self.txtEventDuration.text
                    ],
                   "profileType":"2"] as [String : Any]

        
        
        
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
                
             
                
                
//
//                let alertController = UIAlertController(title: "", message: "user profile updated", preferredStyle:UIAlertControllerStyle.alert)
//
//                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
//                { action -> Void in
                
                    let proficDic = dicData["profile"] as! [String : String]
                    UserDefaults.standard.setValue(proficDic, forKey: "eventProfile")
                    UserDefaults.standard.setValue(nil, forKey: "corporateProfile")
                    UserDefaults.standard.synchronize()
                    UserDefaults.standard.set(3, forKey: "isLogin")
                    UserDefaults.standard.synchronize()
                self.appUserObject?.userType = "2"
                self.appUserObject?.saveToUserDefault()
                    let vc = PAHomeVC(nibName: "PAHomeVC", bundle: nil)
                    vc.isGroupCreate = false
                    self.navigationController?.pushViewController(vc, animated: true)
                
                    self.logOut()
//
//                })
//                self.present(alertController, animated: true, completion: nil)
                
                
                
                
          
        
                SVProgressHUD.dismiss()
            }
            SVProgressHUD.dismiss()
            
        })
        
    }
    
    
    
}
extension PAEvent: UITextFieldDelegate{
    
    

    
 
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
         textField.setLeftPaddingPoints(10)
        self.moveTextField(textField: textField, moveDistance: -120, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.moveTextField(textField: textField, moveDistance: -120, up: false)
    }
    
   
}

