//
//  customSurvay.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 04/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class PACustomSurvay: BaseViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate , SurvayOptionCellDelegate{
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewHieght: NSLayoutConstraint!
    
    @IBOutlet weak var txtQuestion: UITextField!
    @IBOutlet weak var txtSurveyTittle: UITextField!
    @IBOutlet weak var txtOtptionsValue: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet weak var txtExpireDate: UITextField!
    @IBOutlet weak var txtImagepath: UITextField!
    @IBOutlet weak var lblTextHieght: UILabel!
    @IBOutlet weak var viewquition: UIView!
    
    var numberOfRow: Int = 0
    var arrayOptions: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
          self.tableView.register(UINib(nibName:"SurvayOptionCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        self.tableViewHieght.constant = 0.0
        self.txtImagepath.isEnabled = false
      datePicker.translatesAutoresizingMaskIntoConstraints = false

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    
    
    override func viewWillAppear(_ animated: Bool) {
        showDatePicker()
    }
    func showDatePicker(){

        self.txtExpireDate.inputView = self.datePicker
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(self.donedatePicker))
        
        txtExpireDate.inputAccessoryView = toolBar
        
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtExpireDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }

    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickToSubmit(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        self.moveTextField(textField: textField, moveDistance: -120, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.moveTextField(textField: textField, moveDistance: -120, up: false)
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
