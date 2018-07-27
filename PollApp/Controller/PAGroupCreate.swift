//
//  PAGroupCreate.swift
//  PollApp
//
//  Created by Ankleshwar on 04/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import TextFieldEffects
import SVProgressHUD

class PAGroupCreate: BaseViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
     var arraGroupMember : [ContactList] = []
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnCreateGroup: UIButton!
    @IBOutlet weak var viewGroupInfo: UIView!
    var arrayPersnonID: [String] = []
    @IBOutlet weak var txtGroupName: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnCamera.makeCircular()
        self.btnCreateGroup.makeCircular()
        UIView().setShadow(self.viewGroupInfo)
        
        self.collectionView.register(UINib(nibName: "GroupMemberCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
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
            callCreateGroup()
        }
    }
    
    
    
    
    
    func callCreateGroup(){
        SVProgressHUD.show()
        
        
        
        
        let dic = 
            ["name" :  self.txtGroupName.text ?? "",
             "members": self.arrayPersnonID
            ]
             as [String : Any]
        
        
        
        
        ServiceClass().CreateGroup(strUrl: "group", param: dic, header:(self.appUserObject?.access_token)!, completion: {err , dicData   in
            
            if(err != nil){
                
                
                
                
                
                let alertController = UIAlertController(title: "", message: (err?.localizedDescription)!, preferredStyle:UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                { action -> Void in
                    

                    
                    
                })
                self.present(alertController, animated: true, completion: nil)
                
                
                
                
                
                
                SVProgressHUD.dismiss()
                
            }
            else{
                
                print(dicData)
                let alertController = UIAlertController(title: "", message: dicData, preferredStyle:UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                { action -> Void in
                    
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
            
            self.btnCamera.setImage(image, for: .normal)
           
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
    }
    
    
    public func pickColor(alphabet: Character) -> UIColor {
        let alphabetColors = [0x5A8770, 0xB2B7BB, 0x6FA9AB, 0xF5AF29, 0x0088B9, 0xF18636, 0xD93A37, 0xA6B12E, 0x5C9BBC, 0xF5888D, 0x9A89B5, 0x407887, 0x9A89B5, 0x5A8770, 0xD33F33, 0xA2B01F, 0xF0B126, 0x0087BF, 0xF18636, 0x0087BF, 0xB2B7BB, 0x72ACAE, 0x9C8AB4, 0x5A8770, 0xEEB424, 0x407887]
        let str = String(alphabet).unicodeScalars
        let unicode = Int(str[str.startIndex].value)
        if 65...90 ~= unicode {
            let hex = alphabetColors[unicode - 65]
            return UIColor(red: CGFloat(Double((hex >> 16) & 0xFF)) / 255.0, green: CGFloat(Double((hex >> 8) & 0xFF)) / 255.0, blue: CGFloat(Double((hex >> 0) & 0xFF)) / 255.0, alpha: 1.0)
        }
        return  #colorLiteral(red: 0.5568627451, green: 0.1294117647, blue: 0.5882352941, alpha: 1)
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

extension PAGroupCreate: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.arraGroupMember.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GroupMemberCell
        let obj:ContactList = self.arraGroupMember[indexPath.row]
        
        let strName = obj.name
        cell.lblName?.text = strName
        cell.lblImage.text = String(strName![(strName?.startIndex)!])
        cell.lblImage.backgroundColor = pickColor(alphabet: strName![(strName?.startIndex)!])
        cell.lblImage.isEnabled = true
        
        return cell
    }
    
    
}
extension PAGroupCreate : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
       return CGSize(width: collectionViewWidth/3, height: collectionViewWidth/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
