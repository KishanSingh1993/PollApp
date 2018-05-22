//
//  QuestionCellTableViewCell.swift
//  PollApp
//
//  Created by Ankleshwar on 22/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class QuestionCellTableViewCell: UITableViewCell {

    @IBOutlet weak var lblText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    
         lblText.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
