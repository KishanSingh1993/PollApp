//
//  PAOTPVC.swift
//  PollApp
//
//  Created by Ankleshwar on 13/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class PAOTPVC: UIViewController {

    @IBOutlet weak var viewOtp: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

            UIView().setShadow(self.viewOtp)
      
    }


    @IBAction func clickToVerify(_ sender: Any) {
        let  viewController = PAProfile(nibName: "PAProfile", bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
   

}

extension PAOTPVC: UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
}
