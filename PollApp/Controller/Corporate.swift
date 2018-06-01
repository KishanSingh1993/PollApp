//
//  Corporate.swift
//  PollApp
//
//  Created by Ankleshwar on 31/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class Corporate: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
  

}
