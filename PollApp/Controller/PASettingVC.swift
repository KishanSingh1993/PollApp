//
//  PASettingVC.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 24/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class PASettingVC: UIViewController {

    @IBOutlet weak var tablView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

          self.tablView.register(UINib(nibName: "SettingsCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
extension PASettingVC:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") as! SettingsCell
        let mattrStr = NSMutableAttributedString(string: "Anuradha Dwivedi", attributes: [kCTFontAttributeName as NSAttributedStringKey: UIFont(name: "HelveticaNeue-Medium", size: 17.0) ,NSAttributedStringKey.foregroundColor: UIColor.blue])
        mattrStr.append(NSAttributedString(string: "\n\("i Love You")", attributes: [kCTFontAttributeName as NSAttributedStringKey: UIFont(name: "HelveticaNeue", size: 14.0)]))

        cell.lblText.attributedText = mattrStr
       
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

}
