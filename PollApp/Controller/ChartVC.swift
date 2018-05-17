//
//  ChartVC.swift
//  PollApp
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 17/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class ChartVC: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let cellId = "cellId"
    
    let values: [CGFloat] = [12, 80, 20, 40]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        
        collectionView?.register(BarCell.self, forCellWithReuseIdentifier: cellId)
        
        (collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values.count
    }
    
    func maxHeight() -> CGFloat {
        return view.frame.height - 20 - 44 - 8
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BarCell
        
        if let max = values.max() {
            let value = values[indexPath.item]
            let ratio = value / max
            
            cell.barHeightConstraint?.constant = maxHeight() * ratio
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: maxHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 10)
    }
    
}

