//
//  MyPollVC.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 18/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import SVProgressHUD

class MyPollVC: BaseViewController , QueSubmitionDelegate,HomeCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
     var arrHomeProductData : Array<Any> = []
    
    @IBOutlet weak var viewTable: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callThePollData()
        self.tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
       // self.viewTable.addShadow()
    }


    
    override func viewDidLayoutSubviews() {
        self.topView.applyGradient(colours: [self.color1,self.color2])
        
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
    
    func setDataWithQuestion(index: Int, arrQuestion: Any) {
        print(index,arrQuestion)
        _ = IndexSet(integer: index)
        //self.tableView.reloadSections(indexSet, with: .automatic)
    }
    
    
    func didTapShareButton(_ sender: UIButton) {
        if let indexPath = getCurrentCellIndexPath(sender) {
            
            print(indexPath.section)
            
            let Object =  self.arrHomeProductData[indexPath.section] as! HomeScreenData
            let  viewChat = PAChatVC(nibName: "PAChatVC", bundle: nil)
            viewChat.isShare = true
            viewChat.strShareId = Object.id
            self.navigationController?.pushViewController(viewChat, animated: true)
        }
    }
    
    
    
    func getCurrentCellIndexPath(_ sender: UIButton) -> IndexPath? {
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath: IndexPath = tableView.indexPathForRow(at: buttonPosition) {
            return indexPath
        }
        return nil
    }
    
    
    
    
    func callThePollData(){
        SVProgressHUD.show()
        let strUrl = "survey?" + (self.appUserObject?.userId)! + "=self"
        
        ServiceClass().homeScreenData(strUrl: strUrl, header: (self.appUserObject?.access_token)!, completion: {err , arrData   in
            
            if(err != nil){
                
                
                
                
                
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
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            }
            SVProgressHUD.dismiss()
            
        })
    }
    
    
}


extension MyPollVC: UITableViewDelegate,UITableViewDataSource{
    
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
        cell.delegate = self as? HomeCellDelegate
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
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if section == arrHomeProductData.count-1 {
//            return 5.0
//        }else{
//            return 20.0
//        }
//
//    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
                        return 0.0
                    }else{
                        return 20.0
                    }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let obj:HomeScreenData = arrHomeProductData[indexPath.section] as! HomeScreenData
        
        let vc = QueSubmition(nibName: "QueSubmition", bundle: nil)
        vc.delegate = self
        vc.objectData = obj
        
        
        
        
        vc.index = indexPath.section
        
        
        // present(vc, animated: true, completion: nil)
        guard self.nullToNil(value: obj.selfSurvey) != nil else{
            vc.strSurvay = ""
            present(vc, animated: true, completion: nil)
            return
        }
        vc.strSurvay = obj.selfSurvey.questions[0].givenAnswer
        present(vc, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
