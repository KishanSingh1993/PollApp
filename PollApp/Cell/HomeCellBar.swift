//
//  HomeCell.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 14/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

import Charts
import BusinessChat


protocol HomeCellBarDelegate: class {
    func didTapShareButton(_ sender: UIButton)
}


class HomeCellBar: UITableViewCell ,IAxisValueFormatter {

    
weak var axisFormatDelegate: IAxisValueFormatter?
    var delegate:HomeCellBarDelegate?
    @IBOutlet weak var lblNumberOfViews: UILabel!

    @IBOutlet weak var lblTimes: UILabel!
    @IBOutlet weak var viewChart: BarChartView!
   var result: [BarEntry] = []

    var dataEntries: [BarChartDataEntry] = []
    let sideSelectorHeight: CGFloat = 50
    var entries: [ChartDataEntry] = Array()
 var months = [String]()
    var unitsSold = [Double]()
 
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lblName: UILabel!
    
    


    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
       
      
        
        
        axisFormatDelegate = self
//        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
//        unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        // setChart(_ dataPoints:months,_ forY: unitsSold)
       
     
       

       
        viewChart.leftAxis.drawGridLinesEnabled = false
        viewChart.rightAxis.drawGridLinesEnabled = false
        viewChart.xAxis.drawGridLinesEnabled = false
        viewChart.drawGridBackgroundEnabled = false
        viewChart.xAxis.spaceMin  = 1.0
//
        
        //Left axis bottom
        viewChart.leftAxis.spaceBottom = 0.0

          viewChart.chartDescription?.text = ""
//        let yaxis = viewChart.getAxis(YAxis.AxisDependency.left)
//        yaxis.drawLabelsEnabled = false
//        yaxis.enabled = false
////
//        let xaxis = viewChart.getAxis(YAxis.AxisDependency.right)
//        xaxis.drawLabelsEnabled = false
//        xaxis.enabled = false
        
        viewChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        viewChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)

        
      
        
        
}
 
   
    
    func  cellConfig(arrOption : [Option]) {
        
        months.removeAll()
        unitsSold.removeAll()
        result.removeAll()
       
        
        for i in 0..<arrOption.count{
            
            let value = arrOption[i].count
            let name = arrOption[i].option
            if let count = value {
                unitsSold.append(Double(count))
            }
            if let name = name {
                months.append(name)
            }
           
        }
         setChart(dataEntryX: months, dataEntryY: unitsSold)
 
        
    }
    
    
    
    

    
    func setChart(dataEntryX forX:[String],dataEntryY forY: [Double]) {
        
        
        viewChart.noDataText = "You need to provide data for the chart."
        var dataEntries:[BarChartDataEntry] = []
        for i in 0..<forX.count{
            // print(forX[i])
            // let dataEntry = BarChartDataEntry(x: (forX[i] as NSString).doubleValue, y: Double(unitsSold[i]))
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(forY[i]) , data: months as AnyObject?)
            print(dataEntry)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "A")
        chartDataSet.colors = [#colorLiteral(red: 0.5568627451, green: 0.1294117647, blue: 0.5882352941, alpha: 1)]
        let chartData = BarChartData(dataSet: chartDataSet)
        viewChart.data = chartData
        let xAxisValue = viewChart.xAxis
    
  
        
        xAxisValue.valueFormatter =  axisFormatDelegate
        xAxisValue.labelPosition = .bottom
        
        
    }

    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let index = Int(value.rounded())
        print(index)
        guard months.indices.contains(index), index != Int(value) else { return "" }
        return months[index]
      
    }
    
    
 
    
    

}
