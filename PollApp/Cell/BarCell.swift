//
//  BarCell.swift
//  BarChartLiveStream
//
//  Created by Brian Voong on 3/19/17.
//  Copyright © 2017 Lets Build That App. All rights reserved.
//

import UIKit

class BarCell: UICollectionViewCell {
    
    let barView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9585814475, green: 0.6207251014, blue: 0.008665860589, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lbl: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        lbl.font = UIFont(name:"Helvetica Neue", size: 13.0)
        return lbl
    }()
    
    
    var barHeightConstraint: NSLayoutConstraint?
    
    override var isHighlighted: Bool {
        didSet {
            barView.backgroundColor =  #colorLiteral(red: 0.9585814475, green: 0.6207251014, blue: 0.008665860589, alpha: 1)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(barView)
        addSubview(lbl)
        
//        barView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        barHeightConstraint = barView.heightAnchor.constraint(equalToConstant: 300)
        barHeightConstraint?.isActive = true
        
        barHeightConstraint?.constant = 100
        
//        barView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        barView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant:0).isActive = true
        
        barView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        barView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        
        lbl.bottomAnchor.constraint(equalTo: bottomAnchor,constant:0).isActive = true
        
        lbl.leftAnchor.constraint(equalTo: leftAnchor,constant:0).isActive = true
    
        lbl.widthAnchor.constraint(equalTo: widthAnchor,constant:200).isActive = true
      


        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
