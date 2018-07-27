//
//  HomeCell.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 14/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

import Charts



protocol HomeCellDelegate: class {
    func didTapShareButton(_ sender: UIButton)
}


class HomeCell: UITableViewCell  {

    var delegate:HomeCellDelegate?
    @IBOutlet weak var lblNumberOfViews: UILabel!
    weak var axisFormatDelegate: IAxisValueFormatter?
    @IBOutlet weak var lblTimes: UILabel!
    @IBOutlet weak var viewChart: BasicBarChart!
   var result: [BarEntry] = []
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
       
        
        
      
     
       

       
        
        //ChartViewProperty()
        
      
        
        
}
 
    @IBAction func clickToShare(_ sender: Any) {
        delegate?.didTapShareButton(sender as! UIButton)
    }
    

    
    
    func  cellConfig(arrOption : [Option]) {
        
        months.removeAll()
        unitsSold.removeAll()
        result.removeAll()
       var yAxis = 0.0
        
        for i in 0..<arrOption.count{
        
            let value = arrOption[i].count
            var valueGrap = Int()
            var height: Float!
            
            if value == 0{
                
                 valueGrap = value!
                
                height = Float(value!) / 10.0
                
             
                
            }
            else{
                 valueGrap = value!
                
                height = Float(value!) / 10.0
                
                print(height)
                
                height = height + 0.1
            }
      
            
            result.append(BarEntry(color: #colorLiteral(red: 0.5568627451, green: 0.1294117647, blue: 0.5882352941, alpha: 1), height: height, textValue: "\(String(describing: valueGrap))", title:arrOption[i].option, yAxis: "\(yAxis)%"))
            yAxis = yAxis + 2.0
        }
        
        print("UnitData---------------:\(unitsSold)")
        
        let dataEntries = generateDataEntries()
        let width = CGFloat(self.frame.size.width) / CGFloat(arrOption.count)
        
        viewChart.barWidth = width - 40
        viewChart.dataEntries = dataEntries
        
    }
    
    
    
    
    
    
    func generateDataEntries() -> [BarEntry] {
        
        return result
    }
    
    
    

    
}
