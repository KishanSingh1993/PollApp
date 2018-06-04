//
//  SurvayOptionCell.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 04/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit


protocol SurvayOptionCellDelegate: class {
    func didTapButton(_ sender: UIButton)
}



class SurvayOptionCell: UITableViewCell {
    
     weak var delegate: SurvayOptionCellDelegate?
    
    @IBOutlet weak var lblOptionTittle: UILabel!
    
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func clickToRevoe(_ sender: Any) {
        delegate?.didTapButton(sender as! UIButton)
    }
    
    
    
}
