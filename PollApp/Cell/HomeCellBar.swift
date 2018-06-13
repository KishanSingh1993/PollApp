//
//  HomeCell.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 14/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

import Charts



protocol HomeCellBarDelegate: class {
    func didTapShareButton(_ sender: UIButton)
}


class HomeCellBar: UITableViewCell  {

    var delegate:HomeCellBarDelegate?
    @IBOutlet weak var lblNumberOfViews: UILabel!

    @IBOutlet weak var lblTimes: UILabel!
    @IBOutlet weak var viewChart: BasicBarChart!
   var result: [BarEntry] = []

    var dataEntries: [BarChartDataEntry] = []
    let sideSelectorHeight: CGFloat = 50
    var entries: [ChartDataEntry] = Array()
 var months = [String]()
    var unitsSold = [Double]()
 
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lblName: UILabel!
    
    
//    var months = ["Jan", "Feb", "Mar", "Apr", "May"]
//    var unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0]
//    let unitsBought = [10.0, 14.0, 60.0, 13.0, 2.0]

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        UIView().setShadow(self.contentView)
       //viewChart.dele
        
        
      
     
       

       
        
      
        
      
        
        
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
