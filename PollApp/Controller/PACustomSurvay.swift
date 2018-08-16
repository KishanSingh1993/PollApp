//
//  customSurvay.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 04/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import SVProgressHUD
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class PACustomSurvay: BaseViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate , SurvayOptionCellDelegate{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtAge: UITextField!
     var arrIteam :Array<Any>?
    @IBOutlet weak var tableViewHieght: NSLayoutConstraint!
    @IBOutlet weak var txtGender: UITextField!
     var arrQuestion = [[String: Any]]()
    @IBOutlet weak var txtQuestion: UITextField!
    @IBOutlet weak var txtSurveyTittle: UITextField!
    @IBOutlet weak var txtOtptionsValue: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var pickerView: UIPickerView!
     var strValue: String?
    @IBOutlet weak var txtExpireDate: UITextField!
    @IBOutlet weak var txtImagepath: UITextField!
    @IBOutlet weak var lblTextHieght: UILabel!
    @IBOutlet weak var viewquition: UIView!
    var strType = "10"
    var imageUser = UIImage()
    var numberOfRow: Int = 0
    var arrayOptions: [String] = []
    var lat : String = ""
    var lng : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageUser = UIImage(named: "user.png")!
      
        
        self.tableView.register(UINib(nibName:"SurvayOptionCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        self.tableViewHieght.constant = 0.0
        self.txtImagepath.isEnabled = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
       
        arrQuestion = (setDataWithLocalJson("NextVersion") as NSArray as? Array<Dictionary<String, Any>>)!
    }

    override func viewWillAppear(_ animated: Bool) {
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        showDatePicker()

       // showPicker()
        
        
    }
    
    
    
    func showDatePicker(){
        
        self.strType = "2"
        self.txtExpireDate.inputView = self.datePicker
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.donedatePicker))
        
        txtExpireDate.inputAccessoryView = toolBar
        
        
    }
    
    func callApiCustumSurvey(){
        
        SVProgressHUD.show()
        
        let strJson = self.json(from: arrayOptions)
     
    
        let dic = ["name": self.txtSurveyTittle.text ?? "",
                   "question": self.txtQuestion.text ?? "",
                   "options": strJson ?? "",
                   "expireAt":self.txtExpireDate.text ?? "",
                   "groupIds":"",
                   "age": self.txtAge.text ?? "" ,
                   "gender":self.txtGender.text ?? "" ,
                   "city":"Delhi",
                   "lat":self.lat,
                   "lng": self.lng] as! [String : AnyObject]
        
    
        print(dic)
        
        
        ServiceClass().customSurvey(strUrl: "survey", param: dic , img: imageUser, header: (self.appUserObject?.access_token)!, completion: { err, dicdata in
            
            if err != nil{
                 SVProgressHUD.dismiss()
            }
            else{
                
                print(dicdata)
                if dicdata["status"] as! Int == 200 {
                    let alertController = UIAlertController(title: "", message: dicdata["userMessage"] as! String, preferredStyle:UIAlertControllerStyle.alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                    { action -> Void in
                        
                        let vc = PAHomeVC(nibName: "PAHomeVC", bundle: nil)
                       
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    })
                    self.present(alertController, animated: true, completion: nil)
                }
             
                SVProgressHUD.dismiss()
            }
            
            
        })
    }
    
    
    

    
    @IBAction func clickToAddOptions(_ sender: Any) {
        
        if self.txtOtptionsValue.text?.count == 0{
            ECSAlert().showAlert(message: "Please Eneter Your Options", controller: self)
            
        }else{
            self.arrayOptions.append(self.txtOtptionsValue.text!)
            numberOfRow += 1
            
            self.tableViewHieght.constant = CGFloat(10 + numberOfRow * 40)
            
            self.tableView.reloadData()
            self.txtOtptionsValue.text = ""
            self.resignFirstResponder() 
        }
        
        
    }
    
    @IBAction func clickToImagePicker(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        let actionsheet = UIAlertController(title: "Photo Source", message: "Choose A Sourece", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else
            {
                print("Camera is Not Available")
                
                ECSAlert().showAlert(message: "Camera is Not Available", controller: self)
            }
            
            
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction)in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionsheet,animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageUser = image
        if let imgUrl = info[UIImagePickerControllerImageURL] as? URL{
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)
            
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            let data = UIImagePNGRepresentation(image)! as NSData
            data.write(toFile: localPath!, atomically: true)
            //let imageData = NSData(contentsOfFile: localPath!)!
            let photoURL = URL.init(fileURLWithPath: localPath!)//NSURL(fileURLWithPath: localPath!)
            print(photoURL)
            self.txtImagepath.text = "\(photoURL)"
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
    }

    
    
  

    
    @objc func donedatePicker(){
        
        if strType == "0" {
            self.txtGender.text = strValue
        }else if strType == "1" {
            self.txtAge.text = strValue
        }
        else{
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/YYYY"
            txtExpireDate.text = formatter.string(from: datePicker.date)
        }
        
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }

    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToSubmit(_ sender: Any) {
        if self.txtSurveyTittle.text?.count == 0{
            ECSAlert().showAlert(message: "Please select tittle", controller: self)
        }
        else if self.txtQuestion.text?.count == 0{
            ECSAlert().showAlert(message: "Please enter the Question", controller: self)
        }  else if self.arrayOptions.count == 0{
            ECSAlert().showAlert(message: "Please enter the options", controller: self)
        }else if self.txtExpireDate.text?.count == 0{
            ECSAlert().showAlert(message: "Please enter the survey expire date", controller: self)
        }
        else{
            callApiCustumSurvey()
        }
       
    }
    
    func didTapButton(_ sender: UIButton) {
        if let indexPath = getCurrentCellIndexPath(sender) {
            self.arrayOptions.remove(at: indexPath.section)
            numberOfRow -= 1
            
            self.tableViewHieght.constant = CGFloat(10 + numberOfRow * 40)
            self.tableView.reloadData()
            print(indexPath.section)
        }
    }
    
    func getCurrentCellIndexPath(_ sender: UIButton) -> IndexPath? {
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath: IndexPath = tableView.indexPathForRow(at: buttonPosition) {
            return indexPath
        }
        return nil
    }
    
}


extension PACustomSurvay: UITextFieldDelegate {
    
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
           self.pickerView.reloadAllComponents()
            self.strType = "0"
            self.arrIteam = arrQuestion[0]["value"] as? Array
            self.txtGender.inputView = self.pickerView
            let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.donedatePicker))
            txtGender.inputAccessoryView = toolBar
            self.pickerView.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(pickerView, didSelectRow: 0, inComponent: 0)
            
        }else if textField == self.txtAge{
           self.pickerView.reloadAllComponents()
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
        }else if textField == self.txtExpireDate {
            self.strType = "2"
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       // self.moveTextField(textField: textField, moveDistance: -50, up: false)
    }
}



extension PACustomSurvay:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrayOptions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! SurvayOptionCell
        
        cell.lblOptionTittle?.text = arrayOptions[indexPath.section]
        cell.delegate = self
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.black.cgColor
       
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    
    
    
}


extension PACustomSurvay : UIPickerViewDelegate,UIPickerViewDataSource{
    
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
extension PACustomSurvay: GMSAutocompleteViewControllerDelegate {
    
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
