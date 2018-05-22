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
    
    @IBOutlet weak var lblTimes: UILabel!
   
    weak var chartView: BarsChart!
    @IBOutlet weak var viewChart: viewChart!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      
        UIView().setShadow(self.contentView)
        
       
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configeCell(with arrayOption: [Option]){
        self.viewChart.reloadCollection(arrData: arrayOption)
        
    }
  
    
}
