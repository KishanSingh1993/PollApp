//
//  PASettingVC.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 24/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class PASettingVC: BaseViewController {
    var arrValue: Array<Dictionary<String,Any>>?
    @IBOutlet weak var tablView: UITableView!
    @IBOutlet weak var btnSwitch: UIButton!
    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var lblProfileType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrValue = setDataWithLocalJson("Setting") as NSArray as? Array<Dictionary<String, Any>>
          self.tablView.register(UINib(nibName: "SettingsCell", bundle: nil), forCellReuseIdentifier: "Cell")
        if (self.appUserObject?.userType)! == "0"{
             self.lblProfileType.text = "Personal"
        }else  if (self.appUserObject?.userType)! == "1"{
            self.lblProfileType.text = "Corporate"
        }else {
            self.lblProfileType.text = "Event"
        }
        self.btnSwitch.layer.cornerRadius = 5.0
        
       
    }

    
    override func viewDidLayoutSubviews() {
        self.viewTop.applyGradient(colours: [self.color1,self.color2])
        self.btnSwitch.applyGradient(colours: [self.btnColor1,self.btnColor2])
    }
    

    @IBAction func clickToSwitch(_ sender: Any) {
        let vc = PAProfile(nibName:"PAProfile", bundle: nil)
        vc.isSwitchProfile = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    


}
extension PASettingVC:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.arrValue?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! SettingsCell
        let strValue =  (arrValue?[indexPath.section]["discription"] as? String)!
        
        
        let mattrStr = NSMutableAttributedString(string:(arrValue?[indexPath.section]["name"] as? String)!, attributes: [kCTFontAttributeName as NSAttributedStringKey: UIFont(name: "HelveticaNeue-Medium", size: 15.0) ,NSAttributedStringKey.foregroundColor: UIColor.black])
    
        mattrStr.append(NSAttributedString(string: "\n\(strValue)", attributes: [kCTFontAttributeName as NSAttributedStringKey: UIFont(name: "HelveticaNeue", size: 12.0),NSAttributedStringKey.foregroundColor: UIColor.gray]))

        cell.lblText.attributedText = mattrStr
        
        if indexPath.section == 0 {
                cell.btnSwitch.isHidden = false
        
        }else if indexPath.section == 1{
            
             cell.btnSwitch.isHidden = false
        }
        else if indexPath.section == 2{
            
            cell.btnSwitch.isHidden = false
        }
        else if indexPath.section == 3{
            
            cell.btnSwitch.isHidden = false
        }
        else{
            cell.btnSwitch.isHidden = true
            
        }
       
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 7 {
            let vc = PALogInVC(nibName: "PALogInVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            UserDefaults.standard.set(0, forKey: "isLogin")
            UserDefaults.standard.synchronize()
        }
    }

}
