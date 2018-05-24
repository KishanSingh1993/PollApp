//
//  SettingsCell.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 24/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {

    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var lblText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
