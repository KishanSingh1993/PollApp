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


class PAHomeVC: BaseViewController,QueSubmitionDelegate ,HomeCellBarDelegate ,UISearchBarDelegate,UIScrollViewDelegate{
    @IBOutlet weak var viewScroll: UIView!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnSurvey: UIButton!
    
    
    var isGroupCreate: Bool!
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
    var viewProfile: PAProfleDetails?
    var viewChat: PAChatVC?
    var viewPoll: MyPollVC?
    var viewSetting:PASettingVC?
    
    @IBOutlet weak var viewScrollHeight: NSLayoutConstraint!
    
    
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
        
        
        
        self.searchBar.delegate = self
        
        btnHome .setButtonImage("homeblack.png")
        self.tableView.register(UINib(nibName: "HomeCellBar", bundle: nil), forCellReuseIdentifier: "Cell")
        
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
        
      
        
    
        
        
        
        
        
    }
    

    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
      
        
        
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let vc = PASearch(nibName: "PASearch", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        self.searchBar.resignFirstResponder()
        searchBar.text = ""
        return false
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        
        // Remove focus from the search bar.
        searchBar.endEditing(true)
        
        // Perform any necessary work.  E.g., repopulating a table view
        // if the search bar performs filtering.
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
      
        self.viewSearchBar.applyGradient(colours: [self.color1,self.color2])
    }
    
    
    @IBAction func clickToSurvay(_ sender: Any) {
        
    
            let vc = PACustomSurvay(nibName: "PACustomSurvay", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        
        
       
    }
    
    
    
    @objc func sendContact(){
        
        print(self.arrayContract)
        print("---------In Send Part ------------")
        
        
        
        DispatchQueue.global(qos: .background).async {
            
            print("---------In Second Part ------------")
            
            print("This is run on the background queue")
            
            let dic = ["users":self.arrayContract]
            
            
            ServiceClass().ContactsSend(strUrl: "users/sync", param: dic, header: (self.appUserObject?.access_token)!, completion: {err , arrData   in
                
            })
            
        }
        
        
        
    }
    
    
    
    @objc  func getContact(){
        
        let dispatchGroup = DispatchGroup()
        
        
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request){
                (contact, stop) in
                // Array containing all unified contacts from everywhere
                dispatchGroup.enter()
                print("---------In Frist Part ------------")
                self.contacts.append(contact)
                
                for phoneNumber in contact.phoneNumbers {
                    if let number = phoneNumber.value as? CNPhoneNumber, let label = phoneNumber.label {
                        
                        print("\(contact.givenName) \(contact.familyName)  -- \(number.stringValue)")
                        
                        let  strName = contact.givenName + "" + contact.familyName
                        self.dicUserNumber["name"] = strName
                        var strNumber = number.stringValue
                        
                        
                        
                        strNumber = strNumber.replacingOccurrences(of: " ", with: "")
                        print(strNumber)
                        
                        if strName == "@user"{
                            print(strNumber)
                        }
                        
                        
                        
                        if number.stringValue.count >= 10{
                            
                            if number.stringValue.starts(with: "0") {
                                
                                strNumber = String(strNumber.dropFirst())
                                strNumber = strNumber.replacingOccurrences(of: " ", with: "")
                                
                            }else if number.stringValue.starts(with: "+") {
                                
                                strNumber = ((strNumber as? NSString)?.substring(from: 3))!
                                strNumber = strNumber.replacingOccurrences(of: " ", with: "")
                                print(strNumber)
                                
                            }
                            self.dicUserNumber["mobileNumber"] = strNumber
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        self.arrayContract.add(self.dicUserNumber)
                    }
                    
                    print(self.arrayContract)
                    
                    
                    
                    
                }
                
                
                
                
            }
            dispatchGroup.leave()
            
            
            //
            
            
            print(contacts)
        } catch {
            
            
            print("unable to fetch contacts")
        }
    }
    
    
    
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("+()/".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    
    
    func callHomeScreenValue(){
        SVProgressHUD.show()
        
        ServiceClass().homeScreenData(strUrl: "survey", header: (self.appUserObject?.access_token)!, completion: {err , arrData   in
            
            if(err != nil){
                
                // print(err?.localizedDescription)
                
                
                
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
                self.arrHomeProductData = arrData
                self.tableHeight.constant = CGFloat((self.arrHomeProductData.count)*300)
                 self.viewScrollHeight.constant = CGFloat((self.arrHomeProductData.count)*300 - 200)
              //  self.viewScrollHeight.constant = CGFloat(self.tableView.frame.size.height + 140 + CGFloat((self.arrHomeProductData.count)*15))
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            }
            SVProgressHUD.dismiss()
            
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if self.isGroupCreate == true {
            setChat()
        }
        else{
            setHomeData()
            callHomeScreenValue()
        }
        
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            
            self.getContact()
            self.sendContact()
        }
        
    }
    
    
    
    @IBAction func clickToProfile(_ sender: Any) {
        
        self.searchBar.isHidden = true
        self.btnSurvey.isHidden =  true
        setButtonImg(btn: btnHome, strActive: "home_white.png",btn1: btnProfile, strUnactive1:"identity_yellow.png", btn2: btnChat, strUnactive2: "chat_.png", btn3: btnSearch, strUnactive3: "poll_white.png", btn4: btnSetting, strUnactive4: "settings_white.png")
        
        viewProfile = PAProfleDetails(nibName: "PAProfleDetails", bundle: nil)
         self.viewScrollHeight.constant = 0
        addChildViewController(viewProfile!)
        viewMain.addSubview((viewProfile?.view)!)
        viewProfile?.view.frame = viewMain.bounds
        viewProfile?.willMove(toParentViewController: self)
        
        
        
        
        
        //self.navigationController?.pushViewController(viewProfile!, animated: true)
        setLableTextColor(lbl: self.lblprofile, colorActive: #colorLiteral(red: 0.9568627451, green: 0.6196078431, blue: 0.007843137255, alpha: 1), lbl1: lblHome, colorUnactive: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), lbl2: lblSearch, lbl3: lblGroup, lbl4: lblSetting)
    }
    
    
    @IBAction func clickToChat(_ sender: Any) {
        
        setChat()
    }
    
    
    func setChat(){
         self.viewScrollHeight.constant = 0
        self.searchBar.isHidden = true
        self.btnSurvey.isHidden = true
        setButtonImg(btn: btnHome, strActive: "home_white.png",btn1: btnProfile, strUnactive1:"person_white.png", btn2: btnChat, strUnactive2: "chat_yellow.png", btn3: btnSearch, strUnactive3: "poll_white.png", btn4: btnSetting, strUnactive4: "settings_white.png")
        
        viewChat = PAChatVC(nibName: "PAChatVC", bundle: nil)
        viewChat?.isMySurvey = false
        viewChat?.isShare = false
        addChildViewController(viewChat!)
        viewMain.addSubview((viewChat?.view)!)
        viewChat?.view.frame = viewMain.bounds
        viewChat?.willMove(toParentViewController: self)
        setLableTextColor(lbl: self.lblGroup, colorActive: #colorLiteral(red: 0.9568627451, green: 0.6196078431, blue: 0.007843137255, alpha: 1), lbl1: lblHome, colorUnactive: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), lbl2: lblSearch, lbl3: lblprofile, lbl4: lblSetting)
    }
    
    
    @IBAction func clickToHome(_ sender: Any) {
        
        if self.isGroupCreate == true {
            self.isGroupCreate = false
            setHomeData()
            callHomeScreenValue()
            
        }
        else{
            
            
            setHomeData()
            self.viewScrollHeight.constant = CGFloat((self.arrHomeProductData.count)*300 - 200)
            self.tableView.reloadData()
            
            
        }
        
        
    }
    
    func setHomeData(){
        self.btnSurvey.makeCircular()
        self.btnSurvey.isHidden = false
        setButtonImg(btn: btnHome, strActive: "home_yellow.png",btn1: btnProfile, strUnactive1:"person_white.png", btn2: btnChat, strUnactive2: "chat_.png", btn3: btnSearch, strUnactive3: "poll_white.png", btn4: btnSetting, strUnactive4: "settings_white.png")
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
        self.btnSurvey.isHidden = true
        setButtonImg(btn: btnHome, strActive: "home_white.png",btn1: btnProfile, strUnactive1:"person_white.png", btn2: btnChat, strUnactive2: "chat_.png", btn3: btnSearch, strUnactive3: "poll.png", btn4: btnSetting, strUnactive4: "settings_white.png")
        setLableTextColor(lbl: self.lblSearch, colorActive: #colorLiteral(red: 0.9568627451, green: 0.6196078431, blue: 0.007843137255, alpha: 1), lbl1: lblHome, colorUnactive: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), lbl2: lblprofile, lbl3: lblGroup, lbl4: lblSetting)
        
        
        let  viewPoll = MyPollVC(nibName: "MyPollVC", bundle: nil)
        
        self.viewScrollHeight.constant = 0
        
        addChildViewController(viewPoll)
        viewMain.addSubview((viewPoll.view)!)
        viewPoll.view.frame = viewMain.bounds
        viewPoll.willMove(toParentViewController: self)
        
    }
    
    @IBAction func clickToSetting(_ sender: Any) {
       
        self.searchBar.isHidden = true
        self.btnSurvey.isHidden = true
        setButtonImg(btn: btnHome, strActive: "home_white.png",btn1: btnProfile, strUnactive1:"person_white.png", btn2: btnChat, strUnactive2: "chat_.png", btn3: btnSearch, strUnactive3: "poll_white.png", btn4: btnSetting, strUnactive4: "settingsblack.png")
        
        setLableTextColor(lbl: self.lblSetting, colorActive: #colorLiteral(red: 0.9568627451, green: 0.6196078431, blue: 0.007843137255, alpha: 1), lbl1: lblHome, colorUnactive: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), lbl2: lblprofile, lbl3: lblGroup, lbl4: lblSearch)
        viewSetting = PASettingVC(nibName: "PASettingVC", bundle: nil)
        self.viewScrollHeight.constant = 10
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
    
    func setDataWithQuestion(index: Int, arrQuestion: Any) {
        print(index,arrQuestion)
        let indexSet = IndexSet(integer: index)
        //self.tableView.reloadSections(indexSet, with: .automatic)
    }
    
    
    func didTapShareButton(_ sender: UIButton) {
        if let indexPath = getCurrentCellIndexPath(sender) {
            
            print(indexPath.section)
            
            let Object =  self.arrHomeProductData[indexPath.section] as! HomeScreenData
            viewChat = PAChatVC(nibName: "PAChatVC", bundle: nil)
            viewChat?.isShare = true
            viewChat?.strShareId = Object.id
            self.navigationController?.pushViewController(viewChat!, animated: true)
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

extension PAHomeVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrHomeProductData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! HomeCellBar
        let obj:HomeScreenData = arrHomeProductData[indexPath.section] as! HomeScreenData
        cell.lblName.text = obj.name
        cell.delegate = self
        cell.lblNumberOfViews.text = String(obj.attemptedCount)
        
        
        cell.lblTimes.text = "remains"
        if let ques = obj.questions {
            let option = ques[0].options
            cell.cellConfig(arrOption: option!)
            // print(option)
        }
        
        let dicTime = self.dateDiff(dateStr: obj.expireAt)
        var time = ""
        if  let day = dicTime["DD"]{
            time = "\(day)  days remains"
            cell.lblTimes.text = time
        }else if let hour = dicTime["HH"] {
            
            time = "\(hour) hour remains"
            cell.lblTimes.text = time
        }else if let minute = dicTime["MM"] {
            
            time =  "\(minute) minute remains"
            cell.lblTimes.text = time
        }else if let second = dicTime["SS"]{
            
            time = "\(second) second Remains"
            cell.lblTimes.text = time
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        print("Section value \(section)")
        print("array\(self.arrHomeProductData.count)")
        
        if section == arrHomeProductData.count-1 {
            return 0.0
        }else{
            return 20.0
        }
    }

    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let viewFooter = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 20))
//
//        viewFooter.backgroundColor = 
//
//        return viewFooter
//    }
//    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj:HomeScreenData = arrHomeProductData[indexPath.section] as! HomeScreenData
        
        let vc = QueSubmition(nibName: "QueSubmition", bundle: nil)
        vc.delegate = self
        vc.objectData = obj
        
        
        
        
        vc.index = indexPath.section
        
        
        // present(vc, animated: true, completion: nil)
        guard let myString = self.nullToNil(value: obj.selfSurvey) else{
            vc.strSurvay = ""
            present(vc, animated: true, completion: nil)
            return
        }
        print(obj.selfSurvey.questions[0].givenAnswer)
        vc.strSurvay = obj.selfSurvey.questions[0].givenAnswer
        present(vc, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}


extension String {
    
    func toLengthOf(length:Int) -> String {
        if length <= 0 {
            return self
        } else if let to = self.index(self.startIndex, offsetBy: length, limitedBy: self.endIndex) {
            return self.substring(from: to)
            
        } else {
            return ""
        }
    }
}
