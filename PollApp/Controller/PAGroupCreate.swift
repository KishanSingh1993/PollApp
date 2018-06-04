//
//  PAGroupCreate.swift
//  PollApp
//
//  Created by Ankleshwar on 04/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import TextFieldEffects

class PAGroupCreate: BaseViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    @IBOutlet weak var imageGroup: UIImageView!
    @IBOutlet weak var btnCamera: UIButton!
    
    @IBOutlet weak var txtGroupName: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageGroup.layer.cornerRadius = self.imageGroup.frame.size.width / 2
         self.imageGroup.layer.masksToBounds = true
    }
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clickToCreateGroup(_ sender: Any) {
        if self.txtGroupName.text?.count == 0{
            ECSAlert().showAlert(message: "Please Enter Group Name", controller: self)
        }
        else{
            
        }
    }
    
    
    
    
    
    @IBAction func clickToGroupIcon(_ sender: Any) {
        
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
    @IBOutlet weak var clickToBack: UIButton!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        if let imgUrl = info[UIImagePickerControllerImageURL] as? URL{
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)
            
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            let data = UIImagePNGRepresentation(image)! as NSData
            
            self.imageGroup.image = image
           
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
    }

}
extension PAGroupCreate: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setLeftPaddingPoints(10)
        
    }
    

}
