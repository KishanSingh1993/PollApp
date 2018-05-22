

import UIKit




class viewChart: UIView {


    var collectionView: UICollectionView!
    let cellId = "cellId"
    
    let values: NSMutableArray = [18,5,3,7]
    var arrOption: [Option] = []

    var space : CGFloat!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let flowLayout = UICollectionViewFlowLayout()
 
  
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = self.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.backgroundColor = .white
        

        
        collectionView?.register(BarCell.self, forCellWithReuseIdentifier: cellId)
        
        (collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
  
        self.addSubview(collectionView)
    }
    

    
    func reloadCollection(arrData:[Option]) {
        
        print(arrData)
        for var j in 0..<(arrData.count){
            let valueCount = CGFloat(arrData[j].count)
            self.values.add(valueCount)
        }
        
        self.arrOption = arrData
        
  

        collectionView.reloadData()
    }
}

extension viewChart: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrOption.count
    }
    
    func maxHeight() -> CGFloat {
        
        
        return self.frame.height - 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BarCell
        
         let optionName = arrOption[indexPath.row].option
        let optionValue = arrOption[indexPath.row].count
        
        if let max = optionValue {
            let value = values[indexPath.item] as! CGFloat
            let ratio = value / CGFloat(max)

            cell.barHeightConstraint?.constant = maxHeight() * value
        }
       
//        cell.barHeightConstraint?.constant =  maxHeight() * CGFloat(5)
        cell.lbl.text = optionName
        
        return cell
    }
    
}



extension viewChart : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: maxHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 10)
    }
}
