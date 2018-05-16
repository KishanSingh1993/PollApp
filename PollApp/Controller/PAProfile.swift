//
//  PAProfile.swift
//  PollApp
//
//  Created by Ankleshwar on 13/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class PAProfile: UIViewController {

    @IBOutlet weak var viewPersonal: UIView!
    
     @IBOutlet weak var viewCorporate: UIView!
    
    @IBOutlet weak var viewEvent: UIView!
    
    
    @IBOutlet weak var viewMain: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    UIView().setShadow(viewMain)
        setShadow(viewPersonal)
        setShadow(viewCorporate)
        setShadow(viewEvent)
        
    }


    func setShadow(_ view: UIView){
        
        
    
 
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.6980392157, blue: 1, alpha: 1).cgColor
    }
    

    @IBAction func clickToPersonal(_ sender: Any) {
        let vc = PAHomeVC(nibName: "PAHomeVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
