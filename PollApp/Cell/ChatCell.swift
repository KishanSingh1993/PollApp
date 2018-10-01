//
//  ChatCell.swift
//  PollApp
//
//  Created by Ankleshwar on 05/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblImage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.layer.masksToBounds = true;
        imgView.layer.cornerRadius = imgView.frame.width/2;
        lblImage.layer.masksToBounds = true;
        lblImage.layer.cornerRadius = lblImage.frame.width/2;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
