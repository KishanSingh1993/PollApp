//
//  PAProfleDetails.swift
//  PollApp
//
//  Created by Ankleshwar on 16/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import Kingfisher

class PAProfleDetails: BaseViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewTable: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewScroll: UIView!
    var customArray = NSMutableArray()
     var customArrayTittle = NSMutableArray()
    var dicData : Dictionary<String,Any>? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = UIColor.white
        self.tableView.register(UINib(nibName: "ProfileDetailsCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.viewTable.addShadow()
       
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setValue()
       self.viewHeight.constant = CGFloat(self.customArray.count * 80 + 30)
    }

    
    func setValue(){
        
        
        if (self.appUserObject?.userType)! == "0"{
            self.lblTitle.isHidden = true
            self.imgView.isHidden = false
            self.customArray.removeAllObjects()
            self.customArrayTittle.removeAllObjects()
            dicData = UserDefaults.standard.dictionary(forKey: "socialProfile")
            self.lblTitle.text = "Personal Profile"
            self.imgView.layer.cornerRadius = self.imgView.frame.size.width / 2
            self.imgView.clipsToBounds = true
            print((self.appUserObject?.userImageUrl)!)
            imgView.kf.indicatorType = .activity
            
          
            
            let url = URL(string: (self.appUserObject?.userImageUrl)!)
            imgView.kf.setImage(with: url)
          
            imgView.kf.indicatorType = .none
            
            
            if dicData != nil {
                
                self.customArray.add((self.appUserObject?.userName)!)
                self.customArray.add((self.appUserObject?.email)!)
                self.customArray.add((self.appUserObject?.mobile)!)
         
                self.customArrayTittle.add("Name")
                self.customArrayTittle.add("Email")
                self.customArrayTittle.add("Mobile")
                self.tableView.reloadData()
          
            } else{
                setProfile()
            }
            
            
        }else if (self.appUserObject?.userType)! == "1"{
            self.lblTitle.isHidden = false
            self.imgView.isHidden = true
            self.customArray.removeAllObjects()
            self.customArrayTittle.removeAllObjects()
            dicData = UserDefaults.standard.dictionary(forKey: "corporateProfile")
           self.lblTitle.text = "Corporate Profile"
            
            if dicData != nil {
                self.customArray.add(dicData?["company_name"] ?? "")
                self.customArray.add(dicData?["company_address"] ?? "")
                self.customArray.add(dicData?["company_contact_person"] ?? "")
                self.customArray.add(dicData?["company_email_address"] ?? "")
                self.customArray.add(dicData?["company_website"] ?? "")
                self.customArray.add(dicData?["company_phone_number"] ?? "")
                self.customArrayTittle.add("Company Name")
                self.customArrayTittle.add("Company Address")
                self.customArrayTittle.add("Company Contact Person")
                self.customArrayTittle.add("Company Email Address")
                self.customArrayTittle.add("Company Website")
                self.customArrayTittle.add("Company Phone Number")
                self.tableView.reloadData()
            } else{
                setProfile()
            }
            
     
            
        }else if (self.appUserObject?.userType)! == "2"{
            self.lblTitle.isHidden = false
            self.imgView.isHidden = true
            self.customArray.removeAllObjects()
            self.customArrayTittle.removeAllObjects()
            dicData = UserDefaults.standard.dictionary(forKey: "eventProfile")
            self.lblTitle.text = "Event Profile"
            
            if dicData != nil {
                self.customArray.add(dicData?["event_name"] ?? "")
                self.customArray.add(dicData?["event_date"] ?? "")
                self.customArray.add(dicData?["event_title"] ?? "")
                self.customArray.add(dicData?["contact_person"] ?? "")
                self.customArray.add(dicData?["contact_person_email"] ?? "")
                self.customArray.add(dicData?["contact_person_mobile"] ?? "")
                self.customArrayTittle.add("Event Name")
                self.customArrayTittle.add("Event Date")
                self.customArrayTittle.add("Event Tittle")
                self.customArrayTittle.add("Contact Person")
                self.customArrayTittle.add("Contact Person Email")
                self.customArrayTittle.add("Contact Person Mobile")
                self.tableView.reloadData()
            }
            else{
                    setProfile()
            }
            
            
            
            
        }
        
    }
    
    
    func setProfile(){
        let vc = PAProfile(nibName: "PAProfile", bundle: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    


    override func viewDidLayoutSubviews() {
     //   self.topView.applyGradient(colours: [self.color1,self.color2])
      
       
    }
    
    @IBAction func clickToEdit(_ sender: Any) {
        if (self.appUserObject?.userType)! == "0"{
            let vc = PAPersonalProfile(nibName: "PAPersonalProfile", bundle: nil)
            vc.name = (self.appUserObject?.userName)!
            vc.email = (self.appUserObject?.email)!
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if (self.appUserObject?.userType)! == "1"{
            let vc = Corporate(nibName: "Corporate", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }else if (self.appUserObject?.userType)! == "2"{
            let vc = PAEvent(nibName: "PAEvent", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension PAProfleDetails: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.customArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")  as! ProfileDetailsCell
       
        cell.lblTitle.text = self.customArrayTittle[indexPath.row] as? String
        cell.lblSubTittle.text =  self.customArray[indexPath.row] as? String
        cell.backgroundColor =  UIColor.white
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
