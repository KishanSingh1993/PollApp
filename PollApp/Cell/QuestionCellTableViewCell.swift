//
//  QuestionCellTableViewCell.swift
//  PollApp
//
//  Created by Ankleshwar on 22/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit


private let selectedColor   = #colorLiteral(red: 1, green: 0.631372549, blue: 0, alpha: 1)
private let deselectedColor = UIColor.lightGray


class QuestionCellTableViewCell: UITableViewCell {
    @IBOutlet weak var btnRadio: UIButton!
  
    @IBOutlet weak var radioButton: LTHRadioButton!
    
    @IBOutlet weak var lblText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    
//         lblText.layer.borderWidth = 1.0
    }

    func update(with color: UIColor) {
        backgroundColor             = color
        radioButton.selectedColor   = color == .darkGray ? .white : selectedColor
        radioButton.deselectedColor = color == .darkGray ? .lightGray : deselectedColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            return radioButton.select(animated: animated)
        }
        
        radioButton.deselect(animated: animated)
    }
    
    
    

    
    
    
}
