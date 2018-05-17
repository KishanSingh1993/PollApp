

import UIKit




class viewChart: UIView {


    var collectionView: UICollectionView!
    let cellId = "cellId"
    
    let values: [CGFloat] = [12, 80, 20, 40]

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
    

    
    func reloadCollection(arrData:NSMutableArray) {
        
//        self.arrEmojiPanel = arrData
        collectionView.reloadData()
    }
}

extension viewChart: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values.count
    }
    
    func maxHeight() -> CGFloat {
        
        
        return self.frame.height - 30
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
    
}



extension viewChart : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: maxHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 10)
    }
}
