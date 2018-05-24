//
//  PAHomeVC.swift
//  PollApp
//
//  Created by Ankleshwar on 13/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import SwiftCharts
import SVProgressHUD
import Contacts


    typealias completBlock = (_ error: Error?, _ response: Bool) -> Void


class PAHomeVC: BaseViewController {
    @IBOutlet weak var lblSetting: UILabel!
    
    @IBOutlet weak var lblSearch: UILabel!
    @IBOutlet weak var lblGroup: UILabel!
    @IBOutlet weak var lblprofile: UILabel!
    @IBOutlet weak var lblHome: UILabel!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var viewBottom: UIView!
    var arrHomeProductData : Array<Any> = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewMain: UIView!
    var viewProfile: PAProfile?
    var viewChat: PAChatVC?
    var viewSearch: PASearch?
    var viewSetting:PASettingVC?
    var dicUserNumber : Dictionary = [
        "name" : String(),
    "mobileNumber": Int()
  
        ] as [String : Any]
    
    var arrayContract = NSMutableArray()
    
    let contactStore = CNContactStore()
    var contacts = [CNContact]()
    let keys = [
        CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
        CNContactPhoneNumbersKey,
        CNContactEmailAddressesKey
        ] as [Any]
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        
        btnHome .setButtonImage("homeblack.png")
        self.tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        
        callHomeScreenValue()
        
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            
            self.getContact()
            self.sendContact()
        }
       
        
    }
    
    
    
    func sendContact(){
                            print(self.arrayContract)
        
        
                            DispatchQueue.global(qos: .background).async {
                                print("This is run on the background queue")
        
                                let dic = ["users":self.arrayContract]
        
        
                                ServiceClass().ContactsSend(strUrl: "users/sync", param: dic, completion: {err , arrData   in
        
                                })
        
                            }
        
        
    }
    
    
    
    @objc  func getContact(){
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request){
                (contact, stop) in
                // Array containing all unified contacts from everywhere
               
                   self.contacts.append(contact)
                
                for phoneNumber in contact.phoneNumbers {
                    if let number = phoneNumber.value as? CNPhoneNumber, let label = phoneNumber.label {
                      
                        print("\(contact.givenName) \(contact.familyName)  -- \(number.stringValue)")
                        
                        var  strName = contact.givenName + "" + contact.familyName
                        
                        self.dicUserNumber["name"] = strName
                        self.dicUserNumber["mobileNumber"] = number.stringValue
                        
                         self.arrayContract.add(self.dicUserNumber)
                    }
                    
                    print(self.arrayContract)
                    
         
                }
                
                
                
                
            }
            print(contacts)
        } catch {
            
            
            print("unable to fetch contacts")
        }
    }

    func callHomeScreenValue(){
        SVProgressHUD.show()
        
        ServiceClass().homeScreenData(strUrl: "survey", header: (self.appUserObject?.access_token)!, completion: {err , arrData   in
            
            if(err != nil){
                
                // print(err?.localizedDescription)
                
                
                
                let alertController = UIAlertController(title: "", message: (err?.localizedDescription)!, preferredStyle:UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                { action -> Void in
                    UserDefaults.standard.set(1, forKey: "isLogin")
                    UserDefaults.standard.synchronize()
                    let delegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.setRootcontrooler()
                })
                self.present(alertController, animated: true, completion: nil)
                
                
                
                
                
                
                SVProgressHUD.dismiss()
                
            }
            else{
                self.arrHomeProductData = arrData
                self.tableView.reloadData()
            }
            SVProgressHUD.dismiss()
            
        })
        
    }
 
    override func viewWillAppear(_ animated: Bool) {
        setHomeData()
    }
    
    
    
    @IBAction func clickToProfile(_ sender: Any) {
        self.searchBar.isHidden = true
      setButtonImg(btn: btnHome, strActive: "homewhite.png",btn1: btnProfile, strUnactive1:"userBlack.png", btn2: btnChat, strUnactive2: "chatwhite.png", btn3: btnSearch, strUnactive3: "loupewhite.png", btn4: btnSetting, strUnactive4: "settingswhite.png")
        
        viewProfile = PAProfile(nibName: "PAProfile", bundle: nil)
        
        addChildViewController(viewProfile!)
        viewMain.addSubview((viewProfile?.view)!)
        viewProfile?.view.frame = viewMain.bounds
        viewProfile?.willMove(toParentViewController: self)
           setLableTextColor(lbl: self.lblprofile, colorActive: #colorLiteral(red: 0.9568627451, green: 0.6196078431, blue: 0.007843137255, alpha: 1), lbl1: lblHome, colorUnactive: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), lbl2: lblSearch, lbl3: lblGroup, lbl4: lblSetting)
    }
    
   
    @IBAction func clickToChat(_ sender: Any) {
        self.searchBar.isHidden = true
        setButtonImg(btn: btnHome, strActive: "homewhite.png",btn1: btnProfile, strUnactive1:"userWhite.png", btn2: btnChat, strUnactive2: "chat.png", btn3: btnSearch, strUnactive3: "loupewhite.png", btn4: btnSetting, strUnactive4: "settingswhite.png")
        
        viewChat = PAChatVC(nibName: "PAChatVC", bundle: nil)
        
        addChildViewController(viewChat!)
        viewMain.addSubview((viewChat?.view)!)
        viewChat?.view.frame = viewMain.bounds
        viewChat?.willMove(toParentViewController: self)
             setLableTextColor(lbl: self.lblGroup, colorActive: #colorLiteral(red: 0.9568627451, green: 0.6196078431, blue: 0.007843137255, alpha: 1), lbl1: lblHome, colorUnactive: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), lbl2: lblSearch, lbl3: lblprofile, lbl4: lblSetting)
        
    }
    
  
    @IBAction func clickToHome(_ sender: Any) {
       
        setHomeData()
        self.tableView.reloadData()
        
    }
    
    func setHomeData(){
        
        setButtonImg(btn: btnHome, strActive: "homeblack.png",btn1: btnProfile, strUnactive1:"userWhite.png", btn2: btnChat, strUnactive2: "chatwhite.png", btn3: btnSearch, strUnactive3: "loupewhite.png", btn4: btnSetting, strUnactive4: "settingswhite.png")
        self.lblHome.textColor = #colorLiteral(red: 0.9568627451, green: 0.6196078431, blue: 0.007843137255, alpha: 1)
        
        setLableTextColor(lbl: self.lblHome, colorActive: #colorLiteral(red: 0.9568627451, green: 0.6196078431, blue: 0.007843137255, alpha: 1), lbl1: lblGroup, colorUnactive: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), lbl2: lblSearch, lbl3: lblprofile, lbl4: lblSetting)
        
        self.searchBar.isHidden = false
        if self.childViewControllers.count > 0{
            let viewControllers:[UIViewController] = self.childViewControllers
            for viewContoller in viewControllers{
                viewContoller.willMove(toParentViewController: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParentViewController()
            }
        }
        
    }
    
   
    @IBAction func clickToSearch(_ sender: Any) {
        self.searchBar.isHidden = true
        setButtonImg(btn: btnHome, strActive: "homewhite.png",btn1: btnProfile, strUnactive1:"userWhite.png", btn2: btnChat, strUnactive2: "chatwhite.png", btn3: btnSearch, strUnactive3: "loupeblack.png", btn4: btnSetting, strUnactive4: "settingswhite.png")
         setLableTextColor(lbl: self.lblSearch, colorActive: #colorLiteral(red: 0.9568627451, green: 0.6196078431, blue: 0.007843137255, alpha: 1), lbl1: lblHome, colorUnactive: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), lbl2: lblprofile, lbl3: lblGroup, lbl4: lblSetting)
        
        viewSearch = PASearch(nibName: "PASearch", bundle: nil)
        
        addChildViewController(viewSearch!)
        viewMain.addSubview((viewSearch?.view)!)
        viewSearch?.view.frame = viewMain.bounds
        viewSearch?.willMove(toParentViewController: self)
        
    }
    
    @IBAction func clickToSetting(_ sender: Any) {
        self.searchBar.isHidden = true
        
        setButtonImg(btn: btnHome, strActive: "homewhite.png",btn1: btnProfile, strUnactive1:"userWhite.png", btn2: btnChat, strUnactive2: "chatwhite.png", btn3: btnSearch, strUnactive3: "loupewhite.png", btn4: btnSetting, strUnactive4: "settingsblack.png")
        
               setLableTextColor(lbl: self.lblSetting, colorActive: #colorLiteral(red: 0.9568627451, green: 0.6196078431, blue: 0.007843137255, alpha: 1), lbl1: lblHome, colorUnactive: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), lbl2: lblprofile, lbl3: lblGroup, lbl4: lblSearch)
        viewSetting = PASettingVC(nibName: "PASettingVC", bundle: nil)
        
        addChildViewController(viewSetting!)
        viewMain.addSubview((viewSetting?.view)!)
        viewSetting?.view.frame = viewMain.bounds
        viewSetting?.willMove(toParentViewController: self)
        
    }
    
    func setButtonImg(btn :UIButton, strActive :String,btn1 :UIButton, strUnactive1 :String,   btn2 :UIButton, strUnactive2 :String, btn3 :UIButton, strUnactive3 :String, btn4 :UIButton, strUnactive4 :String){
        btn .setButtonImage(strActive)
        btn1 .setButtonImage(strUnactive1)
        btn2 .setButtonImage(strUnactive2)
        btn3 .setButtonImage(strUnactive3)
        btn4 .setButtonImage(strUnactive4)
        
    }
    
    func setLableTextColor(lbl :UILabel, colorActive :UIColor,lbl1 :UILabel, colorUnactive :UIColor,   lbl2 :UILabel, lbl3 :UILabel, lbl4 :UILabel){
        
        lbl.textColor = colorActive
        lbl1.textColor = colorUnactive
        lbl3.textColor = colorUnactive
        lbl2.textColor = colorUnactive
        lbl4.textColor = colorUnactive
        
        
        
    }
}

extension PAHomeVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrHomeProductData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! HomeCell
        let obj:HomeScreenData = arrHomeProductData[indexPath.section] as! HomeScreenData
        cell.lblName.text = obj.name
        cell.lblNumberOfViews.text = String(obj.attemptedCount)
        cell.lblTimes.text = "remains"
        if let ques = obj.questions {
            let option = ques[0].options
            cell.cellConfig(arrOption: option!)
            print(option)
        }
       
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }

    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let viewFooter = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 10))
       
        viewFooter.backgroundColor = UIColor(rgb: 0xF2F2F2)

        return viewFooter
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj:HomeScreenData = arrHomeProductData[indexPath.section] as! HomeScreenData
        
            let option = obj.questions[0].options
            let vc = QueSubmition(nibName: "QueSubmition", bundle: nil)
            vc.arrQueOption = option!
            present(vc, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
    }

 
    
}
