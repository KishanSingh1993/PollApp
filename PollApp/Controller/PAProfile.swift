//
//  PAProfile.swift
//  PollApp
//
//  Created by Ankleshwar on 13/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import Contacts



class PAProfile: BaseViewController {

    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewPersonal: UIView!
    
     @IBOutlet weak var viewCorporate: UIView!
    @IBOutlet weak var lblPersonal: UILabel!
    
    @IBOutlet weak var lblCorporates: UILabel!
    @IBOutlet weak var viewEvent: UIView!
    
    @IBOutlet weak var lblEvent: UILabel!
    
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var viewMain: UIView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView().setShadow(viewMain)
        setShadow(viewPersonal)
        setShadow(viewCorporate)
        setShadow(viewEvent)
        
        self.viewTop.applyGradient(colours: [self.color1,self.color2])
//        self.viewPersonal.applyGradient(colours: [self.btnColor1,self.btnColor2])

        
        print(self.appUserObject?.access_token)
        lblPersonal.numberOfLines = 0
        lblPersonal.text = "Personal\nProfile"
        lblCorporates.text = "Corporate\nProfile"
         lblEvent.text = "Event\nProfile"
 
        
    }

    @IBAction func clickToDone(_ sender: Any) {
        let vc = PAHomeVC(nibName: "PAHomeVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        UserDefaults.standard.set(3, forKey: "isLogin")
        UserDefaults.standard.synchronize()
    }
    
    func setShadow(_ view: UIView){
        
        
    
 
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 0.9568627451, green: 0.6196078431, blue: 0.007843137255, alpha: 1).cgColor
    }
    


    @IBAction func clickToPersonal(_ sender: Any) {
   
    }
    
    
    
    
}
