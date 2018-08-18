//
//  QueSubmition.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 14/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol QueSubmitionDelegate {
    func setDataWithQuestion(index : Int,arrQuestion: Any)
}


class QueSubmition: BaseViewController,QuestionCellTableViewCellDelegate,HomeCellBarDelegate {
    @IBOutlet weak var btnCheck: UIButton!
     var delegate: QueSubmitionDelegate?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblQue: UILabel!
    var arrQueOption: [Option] = []
    var StartedAt: String!
    var index: Int!
    var objectData : HomeScreenData!
    var objectSurvey: SelfSurvey!
    var optionName: String!
    var isSelected : Bool!
    var isSubmited: Bool!
    var selectedElement = [Int : String]()
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var imgView: UIImageView!
    var selectedIndex:IndexPath?
    
    var strSurvay : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.arrQueOption = objectData.questions[0].options
        
        StartedAt = Date().toDay
         self.isSelected = false

        self.btnCheck.makeCircular()
        self.lblQue.text = objectData.questions[0].question
        
        if isSubmited == true{
            btnCheck.isHidden = true
        }else{
            btnCheck.isHidden = false
        }
       
        print(objectData.id)
        
        callServayID()
        
       
        if strSurvay != "" {
            tableView.register(UINib(nibName: "HomeCellBar", bundle: nil), forCellReuseIdentifier: "Cell");
            self.tableViewHeight.constant = CGFloat(self.arrQueOption.count * 300 + 20)
        }else{
            tableView.register(UINib(nibName: "QuestionCellTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell");
            self.tableViewHeight.constant = CGFloat(self.arrQueOption.count * 50 + 20)
        }
    
        
        
    }
    
    
    
    
    func callServayID(){
        
        
        
       
        
        let str = "surveys/" + objectData.id + "/details"
        
        
        ServiceClass().getSurvayId(strUrl: str, param: [:], header: (self.appUserObject?.access_token)!, completion: {err , dicData   in
            
            if(err != nil){
                
             
                
                
                let alertController = UIAlertController(title: "", message: (err?.localizedDescription)!, preferredStyle:UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                { action -> Void in
                    
                })
                self.present(alertController, animated: true, completion: nil)
                
                
                
                
                
                
                
                
            }
            else{
                print(dicData)
                self.tableView.reloadData()
              
            }
           
            
            
        })
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    

    @IBAction func clickToBack(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    
    
    func callServiceForQue(QueArray: [[String:String ]]){
    
        SVProgressHUD.show()
        
        let strUrl = "users/" + (self.appUserObject?.userId)!+"/survey"
        
        let dic = ["surveyId": objectData.id,
                   "name": objectData.name,
                   "questions":QueArray,
                   "startedAt" : StartedAt] as [String : Any]
        
        ServiceClass().postAnsForQue(strUrl:strUrl, param: dic, header: (self.appUserObject?.access_token)!) { error , arrData  in
            
            if(error != nil){
                
                // print(err?.localizedDescription)
                
                
                
                let alertController = UIAlertController(title: "", message: (error?.localizedDescription)!, preferredStyle:UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                { action -> Void in
                
                })
                self.present(alertController, animated: true, completion: nil)
                
                
                
                
                
                
                SVProgressHUD.dismiss()
                
            }
            else{
                print(arrData)
                let arrQue = arrData[0]
                let strMsg = arrData[1] as! String
                
//                let alertController = UIAlertController(title: "", message:strMsg, preferredStyle:UIAlertControllerStyle.alert)
//
//                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
//                { action -> Void in
//
//                        //self.callServayID()
//                     //self.delegate?.setDataWithQuestion(index: self.index, arrQuestion: arrQue)
//                    self.dismiss(animated: true, completion: nil)
//                })
//                self.present(alertController, animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
                self.btnCheck.isHidden = true
                SVProgressHUD.dismiss()
                
             
               
            }
            
        }
        
        
    }
    
    
    @IBAction func clickToCheck(_ sender: Any) {
        
        if isSelected == false {
            ECSAlert().showAlert(message: "Please Select Option", controller: self)
        }
        else{
            let queArray = [["questionId": objectData.questions[0].id,"givenAnswer":optionName]]
            
            callServiceForQue(QueArray: queArray as! [[String : String]])
        }
        
     

    }
    
    
    func didTapShareButton(_ sender: UIButton) {
        if let indexPath = getCurrentCellIndexPath(sender) {
            
            print(indexPath.section)
            
           
            let viewChat = PAChatVC(nibName: "PAChatVC", bundle: nil)
            viewChat.isShare = true
            viewChat.strShareId = objectData.id
            self.navigationController?.pushViewController(viewChat, animated: true)
        }
    }
    
    
    func setDataWithQuestion(index: Int, arrQuestion: Any) {
        print(index,arrQuestion)
        let indexSet = IndexSet(integer: index)
        //self.tableView.reloadSections(indexSet, with: .automatic)
    }

//
//    @objc func clickToRadio(_ sender: UIButton) {
//        if let indexPath = getCurrentCellIndexPath(sender) {
//
//            print(indexPath.section)
//              let cell = tableView.cellForRow(at: indexPath) as! QuestionCellTableViewCell
//             cell.btnRadio.setButtonImage("off.png")
//            cell.btnRadio.setButtonImage("on.png")
//
//        }
//    }
//
//
//
    func getCurrentCellIndexPath(_ sender: UIButton) -> IndexPath? {
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath: IndexPath = tableView.indexPathForRow(at: buttonPosition) {
            return indexPath
        }
        return nil
    }
//
    
    
    func didToggleRadioButton(_ indexPath: IndexPath) {
        let section = indexPath.section
        let data = arrQueOption[indexPath.section].option
        if let previousItem = selectedElement[section] {
            if previousItem == data {
                selectedElement.removeValue(forKey: section)
                return
            }
        }
        selectedElement.updateValue(data!, forKey: section)
        
    }
    
    
        
    }



extension QueSubmition: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if strSurvay != ""{
            return 1
        }else{
            return self.arrQueOption.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if strSurvay != ""{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! HomeCellBar
            optionName = arrQueOption[indexPath.section].option
             self.btnCheck.isHidden = true
         
            cell.lblName.text = objectData.name
            cell.delegate = self
            cell.lblNumberOfViews.text = String(objectData.attemptedCount)
            
            
            cell.lblTimes.text = "remains"
            if let ques = objectData.questions {
                let option = ques[0].options
                cell.cellConfig(arrOption: option!)
                // print(option)
            }
            
            let dicTime = self.dateDiff(dateStr: objectData.expireAt)
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
            
        }else{
             self.btnCheck.isHidden = false
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! QuestionCellTableViewCell
            optionName = arrQueOption[indexPath.section].option
            
            if  (selectedIndex == indexPath){
                
                cell.lblText.textColor = #colorLiteral(red: 0.9585814475, green: 0.6207251014, blue: 0.008665860589, alpha: 1)
                //
                cell.btnRadio.setButtonImage("on.png")
                cell.btnRadio.isSelected = true
            }
            else{
                
                cell.lblText.textColor = #colorLiteral(red: 0.9585814475, green: 0.6207251014, blue: 0.008665860589, alpha: 1)
                cell.btnRadio.setButtonImage("off.png")
                cell.btnRadio.isSelected = false
            }
            
            
            
            cell.lblText.text = optionName
            
            return cell
        }
        
   
    }
    
  
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if strSurvay != ""{
            return 300
        }else{
            return 50
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         optionName = arrQueOption[indexPath.section].option
        
        if strSurvay != "" {
            
        }else{
            let cell = tableView.cellForRow(at: indexPath) as! QuestionCellTableViewCell
            cell.lblText.textColor = #colorLiteral(red: 0.9585814475, green: 0.6207251014, blue: 0.008665860589, alpha: 1)
            
            optionName = arrQueOption[indexPath.section].option
            self.isSelected = true
          
            selectedIndex = indexPath
            tableView.reloadData()
        }
        
        
        
     

    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! QuestionCellTableViewCell
        self.isSelected = false
        print(arrQueOption[indexPath.section])
        cell.lblText.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.lblText.textColor = #colorLiteral(red: 0.9585814475, green: 0.6207251014, blue: 0.008665860589, alpha: 1)
         cell.btnRadio.setButtonImage("off.png")
        
        
        
    }
    

}
