//
//  YAxisValueFormatter.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 24/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import Foundation
import Charts
class YAxisValueFormatter: NSObject, IAxisValueFormatter {
    
    let numFormatter: NumberFormatter
    
    override init() {
        numFormatter = NumberFormatter()
        numFormatter.minimumFractionDigits = Int(0.2)
        numFormatter.maximumFractionDigits = 1
        
        // if number is less than 1 add 0 before decimal
        numFormatter.minimumIntegerDigits = 1 // how many digits do want before decimal
        numFormatter.paddingPosition = .beforePrefix
        numFormatter.paddingCharacter = "0"
    }
    

    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return numFormatter.string(from: NSNumber(floatLiteral: value))!
    }
}
