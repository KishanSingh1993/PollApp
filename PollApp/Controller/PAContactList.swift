//
//  PAContactList.swift
//  PollApp
//
//  Created by Ankleshwar on 24/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import SVProgressHUD

class PAContactList: BaseViewController {

    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var btnBack: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayPersnonID: [String] = []
    var arraGroupContact : [ContactList] = []
    
    var isHome: Bool!
    
    var contactArray : Array<Any> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
        self.btnAdd.makeCircular()
       self.btnAdd.isHidden = true
        btnBack.isHidden = isHome
        
        callContactData()
        self.tableView.register(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
      
    
       
    }
    
    

    func callContactData(){
      
        
        
     SVProgressHUD.show()
            
          
            
            
            ServiceClass().getContact(strUrl: "users/sync", param: [:], header: (self.appUserObject?.access_token)!, completion: {err , arrData   in
                
                if(err != nil){
                    
                    // print(err?.localizedDescription)
                    
                    
                    
                    let alertController = UIAlertController(title: "", message: (err?.localizedDescription)!, preferredStyle:UIAlertControllerStyle.alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                    { action -> Void in
                       
                    })
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                    
                    
                    
                    
                    SVProgressHUD.dismiss()
                    
                }
                else{
                    self.contactArray = arrData
                    print(self.contactArray)
                    self.tableView.reloadData()
                }
                SVProgressHUD.dismiss()
                
                
            })
            
        
        
        
    }
    
    

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    
  
    @IBAction func clickToAdd(_ sender: Any) {
        print(self.arraGroupContact)
        
        let vc =  PAGroupCreate(nibName: "PAGroupCreate", bundle: nil)
        vc.arraGroupMember = self.arraGroupContact
        vc.arrayPersnonID = self.arrayPersnonID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    

}

extension PAContactList:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.contactArray.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! GroupCell
        
           let obj:ContactList = contactArray[indexPath.section] as! ContactList
        
        let strName = obj.name
        let strPhone = obj.mobileNumber

        cell.lblName?.text = strName
        cell.lblPhone?.text = strPhone
        
        cell.lblImage.text = String(strName![(strName?.startIndex)!])
        cell.lblImage.backgroundColor = pickColor(alphabet: strName![(strName?.startIndex)!])
        cell.lblImage.isEnabled = true
        if obj.registered == 1{
            cell.btnInvite.isHidden = true
        }
        else{
             cell.btnInvite.isHidden = false
        }
        if self.arrayPersnonID.index(of: obj.id) != nil {
                cell.accessoryType = .checkmark
                self.btnAdd.isHidden = false
            }else{
                cell.accessoryType = .none
                self.btnAdd.isHidden = true
            }
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let obj:ContactList = contactArray[indexPath.section] as! ContactList
        if obj.registered == 1{
            if let index = self.arrayPersnonID.index(of: obj.id) {
                self.arrayPersnonID.remove(at: index)
                 self.arraGroupContact.remove(at: index)
                if let cell = tableView.cellForRow(at: indexPath) {
                    cell.accessoryType = .none
                     self.btnAdd.isHidden = true
                }
            } else if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
                self.btnAdd.isHidden = false
                self.arrayPersnonID.append(obj.id)
                self.arraGroupContact.append(obj)
            }
            
            
        }
        else{
            ECSAlert().showAlert(message: "User Not Register With Us", controller: self)
        }
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
       //  let obj:ContactList = contactArray[indexPath.section] as! ContactList

       
        
    }


}
