//
//  QueSubmition.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 14/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class QueSubmition: UIViewController {
    @IBOutlet weak var btnFirst: UIButton!
    @IBOutlet weak var btnSecond: UIButton!
    @IBOutlet weak var btnFour: UIButton!
    
    @IBOutlet weak var btnThried: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnFirst.layer.borderWidth = 1
        btnFirst.layer.borderColor = UIColor.black.cgColor
        btnThried.layer.borderWidth = 1
        btnThried.layer.borderColor = UIColor.black.cgColor
        btnFour.layer.borderWidth = 1
        btnFour.layer.borderColor = UIColor.black.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
