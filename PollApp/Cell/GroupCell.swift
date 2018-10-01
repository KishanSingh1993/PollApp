//
//  GroupCell.swift
//  PollApp
//
//  Created by Ankleshwar on 24/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    @IBOutlet weak var lblImage: UILabel!
    @IBOutlet weak var btnInvite: UIButton!
    
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        lblImage.layer.masksToBounds = true;
        lblImage.layer.cornerRadius = lblImage.frame.width/2;
        
    }
    
}
