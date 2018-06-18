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


class QueSubmition: BaseViewController {
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
    var strSurvay : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.arrQueOption = objectData.questions[0].options
        
        StartedAt = Date().toDay
         self.isSelected = false
        tableView.register(UINib(nibName: "QuestionCellTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell");
        self.btnCheck.makeCircular()
        self.lblQue.text = objectData.questions[0].question
        
        if isSubmited == true{
            btnCheck.isHidden = true
        }else{
            btnCheck.isHidden = false
        }
       
        print(objectData.id)
       
        
    
        
        
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
                
                let alertController = UIAlertController(title: "", message:strMsg, preferredStyle:UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                { action -> Void in
                   
                        self.callServayID()
                     self.delegate?.setDataWithQuestion(index: self.index, arrQuestion: arrQue)
                    self.dismiss(animated: true, completion: nil)
                })
                self.present(alertController, animated: true, completion: nil)
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
    
        
    }



extension QueSubmition: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrQueOption.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! QuestionCellTableViewCell
            optionName = arrQueOption[indexPath.row].option
        
//        if let myString =  self.nullToNil( value: objectSurvey.questions[0].givenAnswer as AnyObject ) , !(myString as AnyObject).isEmpty{
//
//            strSurvay = ""
//        }
//        else{
//            strSurvay = objectSurvey.questions[0].givenAnswer
//        }
//
        
       
  
        
        
        if optionName.isEqualToString(find: strSurvay!){
              cell.lblText.backgroundColor = #colorLiteral(red: 0.9585814475, green: 0.6207251014, blue: 0.008665860589, alpha: 1)
              cell.lblText.textColor = UIColor.white
                self.btnCheck.isHidden = true
        }
        else{
              cell.lblText.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
              cell.lblText.textColor = UIColor.black
        }
        
        cell.lblText.text = optionName
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! QuestionCellTableViewCell
        cell.lblText.backgroundColor = #colorLiteral(red: 0.9585814475, green: 0.6207251014, blue: 0.008665860589, alpha: 1)
        cell.lblText.textColor = UIColor.white
        optionName = arrQueOption[indexPath.row].option
          self.isSelected = true

    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! QuestionCellTableViewCell
        self.isSelected = false
        print(arrQueOption[indexPath.row])
        cell.lblText.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.lblText.textColor = UIColor.black
        
        
        
    }
    

}
