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
    var isShare:Bool!
    @IBOutlet weak var btnGroup: UIButton!
      var arrGroupData : Array<Any> = []
    var strShareId : String!
    var strGroupId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnGroup.makeCircular()
        callHomeScreenValue()
        self.tableView.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.tableView.backgroundColor = UIColor.clear
        print(strShareId)
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
    
    
    
    
    
    
    
    
    func callSharePollInGroup(id:String){
        SVProgressHUD.show()
        
        
        
        
        let dic =
            [
             "groupIds": [id,strShareId]
                ]
                as [String : Any]
        
        
        print(dic)
        
        ServiceClass().sharePollInGroup(strUrl: "surveys/surveyId/share", param: dic, header:(self.appUserObject?.access_token)!, completion: {err , dicData   in
            
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
                    vc.isGroupCreate = true
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                })
                self.present(alertController, animated: true, completion: nil)
                
                SVProgressHUD.dismiss()
            }
            SVProgressHUD.dismiss()
            
        })
        
    }
    
    
    
    
    
    
    
    
    
    @IBAction func clickToGroup(_ sender: Any) {
        
        if isShare ==  true{
            btnGroup.setButtonImage("ic_send_white")
            self.callSharePollInGroup(id: strGroupId!)
        }
        else{
            btnGroup.setButtonImage("ic_group_add_white")
            let  viewController = PAContactList(nibName: "PAContactList", bundle: nil)
            viewController.isHome = false
            //viewController.contactArray = self.contactArrayChat
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    
        
        
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
        
        let obj:GroupMember = arrGroupData[indexPath.section] as! GroupMember
        
     
        if self.isShare == true {
            strGroupId =  obj.id
            
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
               btnGroup.setButtonImage("ic_send_white")
            }
            
            
        }
        else{
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
    }
    
    
    
}



