//
//  PAProfleDetails.swift
//  PollApp
//
//  Created by Ankleshwar on 16/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class PAProfleDetails: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewScroll: UIView!
    var dicData : Dictionary<String,Any>? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
       dicData = UserDefaults.standard.dictionary(forKey: "eventProfile")
       // print(dic)
        
    }




}

extension PAProfleDetails: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dicData?.capacity)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")  as! UITableViewCell
        cell.textLabel?.text = "Shivam"
        cell.backgroundColor =  UIColor.white
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
