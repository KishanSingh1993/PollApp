//
//  QuestionCellTableViewCell.swift
//  PollApp
//
//  Created by Ankleshwar on 22/05/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit


protocol QuestionCellTableViewCellDelegate {
    func didToggleRadioButton(_ indexPath: IndexPath)
}


class QuestionCellTableViewCell: UITableViewCell {
    @IBOutlet weak var btnRadio: UIButton!
    var delegate: QuestionCellTableViewCellDelegate?
    @IBOutlet weak var lblText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    
//         lblText.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    
    
//    func initCellItem() {
//        
////        let deselectedImage = UIImage(named: "off.png")?.withRenderingMode(.alwaysTemplate)
////        let selectedImage = UIImage(named: "on.png")?.withRenderingMode(.alwaysTemplate)
//        btnRadio.setButtonImage( "off.png")
//         btnRadio.setButtonImage( "on.png")
//        //btnRadio.setImage(selectedImage, for: .selected)
//        btnRadio.addTarget(self, action: #selector(self.radioButtonTapped), for: .touchUpInside)
//    }
//    
//    @objc func radioButtonTapped(_ radioButton: UIButton) {
//        print("radio button tapped")
//        let isSelected = !self.btnRadio.isSelected
//        self.btnRadio.isSelected = isSelected
//        if isSelected {
//            deselectOtherButton()
//        }
//        let tableView = self.superview as! UITableView
//        let tappedCellIndexPath = tableView.indexPath(for: self)!
//        delegate?.didToggleRadioButton(tappedCellIndexPath)
//    }
//    
//    func deselectOtherButton() {
//        
//        let tableView = self.superview as! UITableView
//        let tappedCellIndexPath = tableView.indexPath(for: self)!
//        let indexPaths = tableView.indexPathsForVisibleRows
//        for indexPath in indexPaths! {
//            if indexPath.row != tappedCellIndexPath.row && indexPath.section == tappedCellIndexPath.section {
//                let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section)) as! QuestionCellTableViewCell
//                cell.btnRadio.isSelected = false
//            }
//        }
//    }

    
    
    
}
