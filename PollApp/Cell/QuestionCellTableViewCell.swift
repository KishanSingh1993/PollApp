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
/*//
 //  HomeCell.swift
 //  PollApp
 //
 //  Created by Opiant tech Solutions Pvt. Ltd. on 14/05/18.
 //  Copyright © 2018 Ankleshwar. All rights reserved.
 //
 
 import UIKit
 import SwiftCharts
 import Charts
 
 
 class HomeCell: UITableViewCell {
 @IBOutlet weak var lblNumberOfViews: UILabel!
 weak var axisFormatDelegate: IAxisValueFormatter?
 @IBOutlet weak var lblTimes: UILabel!
 @IBOutlet weak var viewChart: BarChartView!
 var chart: BarsChart!
 var months: [String]!
 var dataEntries: [BarChartDataEntry] = []
 let sideSelectorHeight: CGFloat = 50
 
 @IBOutlet weak var btnShare: UIButton!
 @IBOutlet weak var lblName: UILabel!
 override func awakeFromNib() {
 super.awakeFromNib()
 
 UIView().setShadow(self.contentView)
 
 
 
 
 
 months = ["Jan", "Feb", "Mar", "Apr"]
 let unitsSold = [0.2,0.4,0.6,0.8]
 
 viewChart.xAxis.labelPosition = .bottom
 
 setChart(dataPoints: months, values: unitsSold)
 
 
 
 
 }
 
 override func setSelected(_ selected: Bool, animated: Bool) {
 super.setSelected(selected, animated: animated)
 
 
 }
 
 func configChart(value: CGFloat , index: Int){
 
 }
 
 
 func setChart(dataPoints: [String], values: [Double]) {
 //viewChart.noDataText = "You need to provide data for the chart."
 
 
 for i in 0..<dataPoints.count {
 print(values[i])
 let dataEntry = BarChartDataEntry(x: values[i], y: Double(i))
 dataEntries.append(dataEntry)
 }
 
 let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
 viewChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
 
 viewChart.xAxis.granularity = 1
 
 
 let chartData = BarChartData(dataSets: [chartDataSet])
 viewChart.data = chartData
 
 }
 
 
 }
*/
