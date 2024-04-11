//
//  BlurCellCollectionViewCell.swift
//  ModsApp
//
//  
//

import UIKit

class BlurCellCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {

            backView.backgroundColor = isSelected ? UIColor(red: 66/255, green: 63/255, blue: 139/255, alpha: 0.4) : .white
        }
    }
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        struct DefaultStruct {
            static let noname = "string"
        }
        cellTitle.textColor = UIColor(red: 60/255, green: 58/255, blue: 126/255, alpha: 1)
        UIDevice.current.userInterfaceIdiom == .phone ? (cellTitle.font = UIFont(name: "VT323-Regular", size: 15)) : (cellTitle.font = UIFont(name: "VT323-Regular", size: 30))
        backgroundColor = .white
    }
    
    

}
