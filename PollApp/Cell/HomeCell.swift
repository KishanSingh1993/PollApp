//
//  HomeCell.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 14/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

import Charts


class HomeCell: UITableViewCell , IAxisValueFormatter {

    
    @IBOutlet weak var lblNumberOfViews: UILabel!
    weak var axisFormatDelegate: IAxisValueFormatter?
    @IBOutlet weak var lblTimes: UILabel!
    @IBOutlet weak var viewChart: BarChartView!
   
    var months = [String]()
    var dataEntries: [BarChartDataEntry] = []
    let sideSelectorHeight: CGFloat = 50
    var entries: [ChartDataEntry] = Array()
   
    var unitsSold = [Double]()
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      
        UIView().setShadow(self.contentView)
       
        
        
      
     
       

       
        
        ChartViewProperty()
        
      
        
        
}
    
    
    fileprivate func ChartViewProperty() {
        
        //barChartView.xAxis.drawGridLinesEnabled = false
        viewChart.xAxis.drawAxisLineEnabled = false
        
        //barChartView
        viewChart.xAxis.drawLabelsEnabled = true
        
        //Space between x axis
//        viewChart.xAxis.spaceMin  = 1.0
//        viewChart.xAxis.spaceMax  = 1.0
        
        //Left axis bottom
        viewChart.leftAxis.spaceBottom = 0.0
        
        //Label Position
        viewChart.xAxis.labelPosition = .bottom
        
        //Description
        viewChart.chartDescription?.text = ""
        
        //Fit Bar
        viewChart.fitBars = false
        
        //Pinch Zoom
        viewChart.pinchZoomEnabled = false
        
        //Right x axis enabled
        self.viewChart.rightAxis.enabled = false
        
        //Animate barchart
//        viewChart.animate(xAxisDuration: 2.0, yAxisDuration: 5.0)
//        viewChart.animate(xAxisDuration: 5.0, yAxisDuration: 5.0, easingOption: .easeInBounce)
    }

    
    
    
    func  cellConfig(arrOption : [Option]){
        
        months.removeAll()
        unitsSold.removeAll()
        
        for i in 0..<arrOption.count{
            
           months.append(arrOption[i].option)
           
           unitsSold.append(Double(arrOption[i].count))
        }
         axisFormatDelegate = self as IAxisValueFormatter
         setChart(dataEntryX: months, dataEntryY: unitsSold)
    }
    
    
    
    func setChart(dataEntryX forX:[String],dataEntryY forY: [Double]) {
       // viewChart.noDataText = "You need to provide data for the chart."
        
        var dataEntries:[BarChartDataEntry] = []
        
        for i in 0..<forX.count{
  
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(0) , data: months as AnyObject?)
            print(dataEntry)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Results")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartDataSet.colors = [UIColor(red: 143/255, green: 33/255, blue: 150/255, alpha: 1)]
        viewChart.data = chartData
      
        viewChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        viewChart.xAxis.granularity = 1
        
        let xAxis = XAxis()
        xAxis.valueFormatter = self
        viewChart.xAxis.valueFormatter = xAxis.valueFormatter
       
       
        viewChart.leftAxis.valueFormatter = YAxisValueFormatter()
    }
    

   
    


    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return months[Int(value) % months.count]}
    
    
}
