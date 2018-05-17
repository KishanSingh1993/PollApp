//
//  HomeCell.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 14/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit
import SwiftCharts


class HomeCell: UITableViewCell {
    @IBOutlet weak var lblNumberOfViews: UILabel!
       var chartView: BarsChart!
    @IBOutlet weak var lblTimes: UILabel!
   
    @IBOutlet weak var viewChart: viewChart!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      
        UIView().setShadow(self.contentView)
        self.viewChart.reloadCollection(arrData: [])
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
  
    
}
