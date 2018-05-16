//
//  PAHomeVC.swift
//  PollApp
//
//  Created by Ankleshwar on 13/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import SwiftCharts

class PAHomeVC: BaseViewController {

    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var viewBottom: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewMain: UIView!
    var viewProfile: PAProfile?
    var viewChat: PAChatVC?
    var viewSearch: PASearch?
    var viewSetting: QueSubmition?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        
       btnHome .setButtonImage("homeblack.png")
        self.tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "Cell")
        print(self.appUserObject?.device_id)
       
    }

 
    override func viewDidLayoutSubviews(){
        
     let  hieght = 220.0 * 2
        
        tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.size.width, height: CGFloat(hieght))
     
        tableView.reloadData()
    }
    
    @IBAction func clickToProfile(_ sender: Any) {
        self.searchBar.isHidden = true
      setButtonImg(btn: btnHome, strActive: "homewhite.png",btn1: btnProfile, strUnactive1:"userBlack.png", btn2: btnChat, strUnactive2: "chatwhite.png", btn3: btnSearch, strUnactive3: "loupewhite.png", btn4: btnSetting, strUnactive4: "settingswhite.png")
        
        viewProfile = PAProfile(nibName: "PAProfile", bundle: nil)
        
        addChildViewController(viewProfile!)
        viewMain.addSubview((viewProfile?.view)!)
        viewProfile?.view.frame = viewMain.bounds
        viewProfile?.willMove(toParentViewController: self)
    }
    
   
    @IBAction func clickToChat(_ sender: Any) {
        self.searchBar.isHidden = true
        setButtonImg(btn: btnHome, strActive: "homewhite.png",btn1: btnProfile, strUnactive1:"userWhite.png", btn2: btnChat, strUnactive2: "chat.png", btn3: btnSearch, strUnactive3: "loupewhite.png", btn4: btnSetting, strUnactive4: "settingswhite.png")
        
        viewChat = PAChatVC(nibName: "PAChatVC", bundle: nil)
        
        addChildViewController(viewChat!)
        viewMain.addSubview((viewChat?.view)!)
        viewChat?.view.frame = viewMain.bounds
        viewChat?.willMove(toParentViewController: self)
        
        
    }
    
  
    @IBAction func clickToHome(_ sender: Any) {
        setButtonImg(btn: btnHome, strActive: "homeblack.png",btn1: btnProfile, strUnactive1:"userWhite.png", btn2: btnChat, strUnactive2: "chatwhite.png", btn3: btnSearch, strUnactive3: "loupewhite.png", btn4: btnSetting, strUnactive4: "settingswhite.png")
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
        
        viewSearch = PASearch(nibName: "PASearch", bundle: nil)
        
        addChildViewController(viewSearch!)
        viewMain.addSubview((viewSearch?.view)!)
        viewSearch?.view.frame = viewMain.bounds
        viewSearch?.willMove(toParentViewController: self)
        
    }
    
    @IBAction func clickToSetting(_ sender: Any) {
        self.searchBar.isHidden = true
        
        setButtonImg(btn: btnHome, strActive: "homewhite.png",btn1: btnProfile, strUnactive1:"userWhite.png", btn2: btnChat, strUnactive2: "chatwhite.png", btn3: btnSearch, strUnactive3: "loupewhite.png", btn4: btnSetting, strUnactive4: "settingsblack.png")
        
        viewSetting = QueSubmition(nibName: "QueSubmition", bundle: nil)
        
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
}

extension PAHomeVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! HomeCell
        cell.cellConfig(0, to: 200, By: 20)

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
}
