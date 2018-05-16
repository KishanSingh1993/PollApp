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
    @IBOutlet weak var viewChart: UIView!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      
        UIView().setShadow(self.contentView)
        let fram =  CGRect(x: 0, y: 0, width: self.viewChart.frame.size.width, height: 122)
        
        let chartConfig = BarsChartConfig(valsAxisConfig: ChartAxisConfig(from: Double(0), to: Double(200), by: Double(200)))
        let chart = BarsChart(frame: fram, chartConfig: chartConfig, xTitle: "", yTitle: "", bars: [("" , 70),("" , 120),("" , 180),("" , 145),],
                              
                              color: #colorLiteral(red: 0.4392156863, green: 0.6980392157, blue: 1, alpha: 1), barWidth: 15)
        self.viewChart.addSubview(chart.view)
        self.chartView = chart
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func cellConfig(_ from: Int, to: Int , By: Int){
       
    
    }
    
}
