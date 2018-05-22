//
//  QueSubmition.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 14/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class QueSubmition: UIViewController {
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
        cell.lblText.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.lblText.textColor = UIColor.black
    }
    

}
