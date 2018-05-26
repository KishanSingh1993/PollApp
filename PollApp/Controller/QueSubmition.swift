//
//  QueSubmition.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 14/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import SVProgressHUD

class QueSubmition: BaseViewController {
    @IBOutlet weak var btnCheck: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblQue: UILabel!
      var arrQueOption: [Option] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "QuestionCellTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell");
        self.btnCheck.makeCircular()
        self.lblQue.text = "Whats your favorite Beverage ?"
    }

    @IBAction func clickToBack(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    
    
    func callServiceForQue(){
        
        SVProgressHUD.show()
        
        var strUrl = "users/" + (self.appUserObject?.userId)!+"/survey"
        
        let dic = ["surveyId": "self.txtPhone.text",
                   "pushToken":"fsafsafsafsadfdas",
                   "deviceId":ECSHelper().getDeviceId()] as [String : Any]
        
        ServiceClass().postAnsForQue(strUrl:strUrl, param: dic) { error , dicData  in
            
            if dicData["status"] as! Int == 200 {
                if let users = dicData["data"] as? [String : Any] {
//                    self.strOTP = users["OTP"] as! String
//                    let mobile  = users["mobileNumber"] as! String
//                    print(self.strOTP)
//                    let  viewController = PAOTPVC(nibName: "PAOTPVC", bundle: nil)
//                    viewController.strPhone = mobile
//                    self.navigationController?.pushViewController(viewController, animated: true)
//
                    
                }
                SVProgressHUD.dismiss()
                
            }
            else{
                
                if let users = dicData["errors"] as? [String : Any] {
                    if let mobile = users["mobileNumber"] as? [String : Any]{
                        
                        let msg = mobile["msg"] as! String
                        ECSAlert().showAlert(message: msg, controller: self)
                        
                    }
                }
                
                SVProgressHUD.dismiss()
                
                
                
            }
            
        }
    }
    
    

        
    }



extension QueSubmition: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrQueOption.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! QuestionCellTableViewCell
         let optionName = arrQueOption[indexPath.row].option
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
        
        

    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! QuestionCellTableViewCell
        
        print(arrQueOption[indexPath.row])
        cell.lblText.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.lblText.textColor = UIColor.black
    }
    

}
