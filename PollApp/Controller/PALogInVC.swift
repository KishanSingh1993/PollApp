//
//  PALogInVC.swift
//  PollApp
//
//  Created by Ankleshwar on 13/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class PALogInVC: UIViewController {

    @IBOutlet weak var viewLogin: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        UIView().setShadow(self.viewLogin)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func clickToNext(_ sender: Any) {
      let  viewController = PAOTPVC(nibName: "PAOTPVC", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    


}

extension PALogInVC: UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
}
