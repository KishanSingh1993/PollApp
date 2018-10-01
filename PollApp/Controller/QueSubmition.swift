//
//  QueSubmition.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 14/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher

protocol QueSubmitionDelegate {
    func setDataWithQuestion(index : Int,arrQuestion: Any)
}


class QueSubmition: BaseViewController,HomeCellBarDelegate {
    @IBOutlet weak var btnCheck: UIButton!
     var delegate: QueSubmitionDelegate?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblQue: UILabel!
    var arrQueOption: [Option] = []
    var arrMultiQueAns = [String]()
    var StartedAt: String!
    var index: Int!
     var currentSection = 0
    var objectData : HomeScreenData!
    var objePollDetails: PollDetails!
    var objectSurvey: SelfSurvey!
    var optionName: String!
    var isSelected : Bool!
    var isSubmited: Bool!
    var selectedElement = [Int : String]()
  
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var imgView: UIImageView!
    var selectedIndex:IndexPath?
    
    var strSurvay : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        StartedAt = Date().toDay
         self.isSelected = false

        
       self.tableView.delegate = nil
        self.tableView.dataSource = nil
        callServayID()
   
        
     
            if strSurvay != "" {
                self.tableView.register(UINib(nibName: "HomeCellBar", bundle: nil), forCellReuseIdentifier: "Cell");
                self.tableViewHeight.constant = CGFloat(self.arrQueOption.count * 300 + 20)
                self.btnCheck.isHidden = true
            }else{
                self.btnCheck.isHidden = false
                self.tableView.register(UINib(nibName: "QuestionCellTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell");
                self.tableViewHeight.constant = CGFloat(self.arrQueOption.count * 50 + 20)
                self.tableView.allowsMultipleSelection = false
            }
   
       
        
        
        
       
   
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    
    func callServayID(){
        
        
        
       SVProgressHUD.show()
        
        let str = "surveys/" + objectData.id + "/details"
        
        
        ServiceClass().getSurvayId(strUrl: str, param: [:], header: (self.appUserObject?.access_token)!, completion: {err , dicData   in
            
            if(err != nil){
                
             
                 //SVProgressHUD.dismiss()
                
                let alertController = UIAlertController(title: "", message: (err?.localizedDescription)!, preferredStyle:UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                { action -> Void in
                    
                })
                self.present(alertController, animated: true, completion: nil)
                
                
                
                
                
                
                
                
            }
            else{
                print(dicData)
                self.objePollDetails = PollDetails(fromJson: dicData)
                let img = self.objePollDetails.data.image
                
                if let imgurl = img , img != "" {
                    
                     let url = URL(string:serverPath+imgurl)
                     self.imgView.kf.setImage(with: url)

                   
                    SVProgressHUD.dismiss()
                }else{
                    self.imgView.image = UIImage(named: "ic_placeholder.png")
                     SVProgressHUD.dismiss()
                }
                if self.objePollDetails.data.multiQuestions == true{
                    self.btnCheck.setButtonTitle("Next")
                }else{
                    self.btnCheck.setButtonTitle("Submit")
                }
                
                 self.lblQue.text = self.objePollDetails.data.questions[0].question
               
                self.arrQueOption = self.objePollDetails.data.questions[0].options
             
                self.tableView.delegate = self
                self.tableView.dataSource = self
     
                if  self.strSurvay != "" {
                    
                    self.tableViewHeight.constant = CGFloat(self.arrQueOption.count * 300 + 20)
                    
                }else{
                    
                    self.tableViewHeight.constant = CGFloat(self.arrQueOption.count * 50 )
                }
                self.tableView.reloadData()
                
               
              
            }
           
            
            
        })
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    

    @IBAction func clickToBack(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    
    
    func callServiceForQue(QueArray: [[String:Any ]]){
    
        SVProgressHUD.show()
        
        let strUrl = "users/" + (self.appUserObject?.userId)!+"/survey"
        
        let dic = ["surveyId": self.objePollDetails.data.id,
                   "name": self.objePollDetails.data.name,
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
            if self.objePollDetails.data.multiQuestions == true {
                
                if self.btnCheck.currentTitle == "Submit" {
                    let queArray = [["questionId": self.objePollDetails.data.questions[0].id ?? "","givenAnswer":arrMultiQueAns]]
                    print(queArray)
                    callServiceForQue(QueArray: queArray )
                }else{
                    currentSection += 1
                    print(currentSection)
                    if currentSection == self.objePollDetails.data.questions.count-1 || self.arrQueOption.count==0{
                        self.btnCheck.setButtonTitle("Submit")
                    }else{
                        
                        
                        tableView.reloadData()
                    }
                }
                
               
               
                
            }else{
                let queArray = [["questionId": self.objePollDetails.data.questions[0].id,"givenAnswer":optionName]]
                
                callServiceForQue(QueArray: queArray as! [[String : Any]])
            }
            
           
        }
        
     

    }
    
    
    func didTapShareButton(_ sender: UIButton) {
        if let indexPath = getCurrentCellIndexPath(sender) {
            
            print(indexPath.section)
            
           
            let viewChat = PAShareVC(nibName: "PAShareVC", bundle: nil)
            viewChat.isShare = true
            viewChat.strShareId = self.objePollDetails.data.id
            self.navigationController?.pushViewController(viewChat, animated: true)
        }
    }
    
    
    func setDataWithQuestion(index: Int, arrQuestion: Any) {
        print(index,arrQuestion)
        let indexSet = IndexSet(integer: index)
        //self.tableView.reloadSections(indexSet, with: .automatic)
    }


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
        } else if self.objePollDetails.data.multiQuestions == true {
            return self.objePollDetails.data.questions.count
        }
        else{
            return self.arrQueOption.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if strSurvay != ""{
            return 1
        } else if self.objePollDetails.data.multiQuestions == true {
            self.arrQueOption = self.objePollDetails.data.questions[self.currentSection].options
            return self.objePollDetails.data.questions[self.currentSection].options.count
        }else{
            return 1
        }
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if strSurvay != ""{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! HomeCellBar
                optionName = arrQueOption[indexPath.section].option
                self.btnCheck.isHidden = true
         
            cell.lblName.text = self.objePollDetails.data.name
             //cell.lblName.text = self.objectData.name
            cell.delegate = self
            cell.lblNumberOfViews.text = String(self.objePollDetails.data.attemptedCount)
            
            //cell.lblNumberOfViews.text = String(self.objectData.attemptedCount)
            cell.lblTimes.text = "remains"
            if let ques = self.objePollDetails.data.questions {
                let option = ques[0].options
                cell.cellConfig(arrOption: option!)
                // print(option)
            }
            
//            if let ques = self.objectData.questions {
//                let option = ques[0].options
//                cell.cellConfig(arrOption: option!)
//                // print(option)
//            }
            
            let dicTime = self.dateDiff(dateStr: self.objePollDetails.data.expireAt)
          //  let dicTime = self.dateDiff(dateStr: self.objectData.expireAt)
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
            
            
            if self.objePollDetails.data.multiQuestions == true {
               
                cell.lblText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.lblQue.text = self.objePollDetails.data.questions[self.currentSection].question
                optionName = arrQueOption[indexPath.row].option
                cell.selectionStyle = .none
                cell.lblText.text = optionName
                if arrQueOption[indexPath.row].next == "" || arrQueOption.count == 0{
                    self.btnCheck.setButtonTitle("Submit")
                }else{
                    self.btnCheck.setButtonTitle("Next")
                }
                

                
              
                
              
            
            }else{
               optionName = arrQueOption[indexPath.section].option
                cell.selectionStyle = .none
                cell.lblText.text = optionName
            }
            
            
          
            
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
        

        if strSurvay != "" {

        }else{
            let cell = tableView.cellForRow(at: indexPath) as! QuestionCellTableViewCell
            cell.lblText.textColor = #colorLiteral(red: 0.9585814475, green: 0.6207251014, blue: 0.008665860589, alpha: 1)

            if self.objePollDetails.data.multiQuestions == true {
                optionName = arrQueOption[indexPath.row].option
                arrMultiQueAns.append(optionName)
                self.isSelected = true
            }else{
                optionName = arrQueOption[indexPath.section].option
                self.isSelected = true
            }
           

          
        }





    }
    
   
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? QuestionCellTableViewCell)?.update(with:  .white)
    }
    
    
    // MARK: - Selection
    
     func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.cellForRow(at: indexPath)?.setSelected(true, animated: true)
        return indexPath
    }
    
   
    
    
    
    

}
