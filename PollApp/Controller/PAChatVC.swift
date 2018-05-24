//
//  PAChatVC.swift
//  PollApp
//
//  Created by Ankleshwar on 13/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class PAChatVC: UIViewController {

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
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
        
    }
    
    
}
