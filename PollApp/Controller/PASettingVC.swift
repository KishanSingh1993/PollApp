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
    override func viewDidLoad() {
        super.viewDidLoad()
        arrValue = setDataWithLocalJson("Setting") as NSArray as? Array<Dictionary<String, Any>>
          self.tablView.register(UINib(nibName: "SettingsCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
//            let vc = PALogInVC(nibName: "", bundle: nil)
//            self.navigationController?.pushViewController(vc, animated: true)
        }
       
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

}
