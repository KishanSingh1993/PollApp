//
//  GroupMember.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 05/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class GroupMember: UICollectionViewCell {

    @IBOutlet weak var lblImage: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblImage.layer.masksToBounds = true;
        lblImage.layer.cornerRadius = lblImage.frame.width/2;
    }

}
