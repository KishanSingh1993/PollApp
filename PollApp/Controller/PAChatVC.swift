//
//  PAChatVC.swift
//  PollApp
//
//  Created by Ankleshwar on 13/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class PAChatVC: UIViewController {
    
        var contactArrayChat = [["name": "Ankleshwar Prasad", "mobileNumber": 7503732194], ["name": "Jay", "mobileNumber": 1234888], ["name": "Krishan Kumar", "mobileNumber": 884038484023], ["name": "Puspayendra", "mobileNumber": 678] , ["name": "+917503732194", "mobileNumber": 7503732194]]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickToGroup(_ sender: Any) {
        
        let  viewController = PAContactList(nibName: "PAContactList", bundle: nil)
        viewController.isHome = false
        viewController.contactArray = self.contactArrayChat
        self.navigationController?.pushViewController(viewController, animated: true)
        
        
    }
    
    
}
