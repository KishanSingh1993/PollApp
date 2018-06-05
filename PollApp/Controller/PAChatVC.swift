//
//  PAChatVC.swift
//  PollApp
//
//  Created by Ankleshwar on 13/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import SVProgressHUD


class PAChatVC: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var btnGroup: UIButton!
      var arrGroupData : Array<Any> = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnGroup.makeCircular()
        callHomeScreenValue()
        self.tableView.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.tableView.backgroundColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func callHomeScreenValue(){
        SVProgressHUD.show()
        
        ServiceClass().getGroupData(strUrl: "group", header: (self.appUserObject?.access_token)!, completion: {err , arrData   in
            
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
                self.arrGroupData = arrData
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            }
            SVProgressHUD.dismiss()
            
        })
        
    }
    
    
    
    
    
    
    @IBAction func clickToGroup(_ sender: Any) {
        
        let  viewController = PAContactList(nibName: "PAContactList", bundle: nil)
        viewController.isHome = false
        //viewController.contactArray = self.contactArrayChat
        self.navigationController?.pushViewController(viewController, animated: true)
        
        
    }
    
    
}


extension PAChatVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrGroupData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! ChatCell
        let obj:GroupMember = arrGroupData[indexPath.section] as! GroupMember
        cell.lblName.text = obj.name
  
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
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
        
//        let obj:HomeScreenData = arrHomeProductData[indexPath.section] as! HomeScreenData
//
//        let vc = QueSubmition(nibName: "QueSubmition", bundle: nil)
//        vc.delegate = self
//        vc.objectData = obj
//
//
//
//
//        vc.index = indexPath.section
//
//
//        // present(vc, animated: true, completion: nil)
//        guard let myString = self.nullToNil(value: obj.selfSurvey) else{
//            vc.strSurvay = ""
//            present(vc, animated: true, completion: nil)
//            return
//        }
//        vc.strSurvay = obj.selfSurvey.questions[0].givenAnswer
//        present(vc, animated: true, completion: nil)
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}



