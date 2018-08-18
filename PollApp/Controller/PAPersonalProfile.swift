//
//  PAPersonalProfile.swift
//  PollApp
//
//  Created by Ankleshwar on 25/07/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import SVProgressHUD





class PAPersonalProfile: BaseViewController {
    @IBOutlet var pickerView: UIPickerView!

    var arrIteam :Array<Any>?
    var arrQuestion = [[String: Any]]()
    var strType = "10"
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    var strValue: String?
    var lat : String = ""
    var lng : String = ""
    var imgUrl: String = ""
    var name = ""
    var email = ""
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtName.text = name
        self.txtEmail.text = email
         arrQuestion = (setDataWithLocalJson("NextVersion") as NSArray as? Array<Dictionary<String, Any>>)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // showPicker()
        
        
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    @objc func donedatePicker(){
        
        if strType == "0" {
            self.txtGender.text = strValue
        }else if strType == "1" {
            self.txtAge.text = strValue
        }
        
        
        
        self.view.endEditing(true)
    }
    
    
    @IBAction func clickToSubmit(_ sender: Any) {
        if self.txtGender.text?.count == 0 {
            ECSAlert().showAlert(message: "Please select gender", controller: self)
        }else if self.txtAge.text?.count == 0 {
            ECSAlert().showAlert(message: "Please select age", controller: self)
        }else if self.txtCity.text?.count == 0 {
              ECSAlert().showAlert(message: "Please select city", controller: self)
        }else{
            self.callSocialScreenValue(age: self.txtAge.text ?? "", city: self.txtCity.text ?? "", gender: self.txtGender.text ?? "", lat: self.lat, lng: self.lng, name: self.txtName.text ?? "" , email: self.txtEmail.text ?? "")
        }
        
        
        
    }
    
    
    
    
    func callSocialScreenValue(age:String,city:String,gender:String,lat:String,lng:String,name:String,email:String){
        SVProgressHUD.show()
        
        
        
        
        let dic = ["userId": (self.appUserObject?.userId)!,
                   "name": name,
                   "email":email,
                   "avatar":(self.appUserObject?.userImageUrl)!,
                   "source": (self.appUserObject?.source)!,
                   "deviceId": (self.appUserObject?.device_id)!,
                   "pushToken": (self.appUserObject?.token)!,
                   "mobileNumber":(self.appUserObject?.mobile)!,
                   "profileType":"0",
                   "age":age,
                   "currentCity":city,
                   "gender":gender,
                   "dob":"",
                   "lat":lat,
                   "lng":lng] as [String : Any]
        
        
        
        
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
                let typeUser = dicData["profileType"] as! Int
                self.appUserObject?.userType = String(typeUser)
                self.appUserObject?.userName = dicData["name"] as! String
                self.appUserObject?.email = dicData["email"] as! String
                self.appUserObject?.mobile = dicData["mobileNumber"] as! String
                self.appUserObject?.userImageUrl = self.imgUrl
                self.appUserObject?.saveToUserDefault()
                UserDefaults.standard.setValue(dicData , forKey: "socialProfile")
                UserDefaults.standard.synchronize()
                
                UserDefaults.standard.set(3, forKey: "isLogin")
                UserDefaults.standard.synchronize()
                let vc = PAHomeVC(nibName: "PAHomeVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
                
                
                
                
                
                
                
                
                SVProgressHUD.dismiss()
            }
            SVProgressHUD.dismiss()
            
        })
        
    }
    
}

extension PAPersonalProfile: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Print place info to the console.
        print("Place name: \(place.name)")
        //        print("Place address: \(place.formattedAddress)")
        //        print("Place attributions: \(place.attributions)")
        let lat = place.coordinate.latitude
        let lon = place.coordinate.longitude
        self.lat = String(lat)
        self.lng = String(lon)
        
        print("lat lon",lat,lon)
        
        self.txtCity.text = place.name
        
        // TODO: Add code to get address components from the selected place.
        
        // Close the autocomplete widget.
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Show the network activity indicator.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // Hide the network activity indicator.
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}


extension PAPersonalProfile: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setLeftPaddingPoints(10)
        // self.moveTextField(textField: textField, moveDistance: 50, up: true)
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Set a filter to return only addresses.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        
        
        if textField == self.txtGender {
            
            self.strType = "0"
            self.arrIteam = arrQuestion[0]["value"] as? Array
            self.txtGender.inputView = self.pickerView
            let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.donedatePicker))
            txtGender.inputAccessoryView = toolBar
            self.pickerView.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(pickerView, didSelectRow: 0, inComponent: 0)
            
        }else if textField == self.txtAge{
            
            self.strType = "1"
            self.arrIteam = arrQuestion[1]["value"] as? Array
            self.txtAge.inputView = self.pickerView
            let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.donedatePicker))
            txtAge.inputAccessoryView = toolBar
            self.pickerView.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(pickerView, didSelectRow: 0, inComponent: 0)
            
        }else if textField == self.txtCity {
            
            textField.resignFirstResponder()
            present(autocompleteController, animated: true, completion: nil)
        }
        
    }
    

}
extension PAPersonalProfile : UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        
        return 1
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        return arrIteam!.count
        
        
        
        
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return arrIteam?[row] as? String
        
        
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        
        self.strValue = arrIteam?[row] as? String
        
        
        
    }
}
