//
//  MyWorksCollectionViewCell.swift
//  ModsApp
//
//  Created by Vladimir Pisarenko on 06.07.2023.
//

import UIKit

final class MyWorksCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        struct DefaultStruct {
            static let noname = "string"
        }
        cellImage.image = nil
    }
    
    private func lets_configureUI() {
        struct DefaultStruct {
            static let noname = "string"
        }
        layer.cornerRadius = 10
        backgroundColor = UIColor(named: "Rhino")
        titleLabel.textColor = .white
    }
    
    func lets_setupCell(_ data: EditorItemLocalRealmModelElement) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if data.imageData.count == 0 {
            
        } else {
            cellImage.image = UIImage(data: data.iconData)
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            titleLabel.font = UIFont(name: "VT323-Regular", size: 30)
        } else {
            titleLabel.font = UIFont(name: "VT323-Regular", size: 20)
        }
        
        titleLabel.text = data.name.uppercased()
        print("titleLabel.text", titleLabel.text)
    }
}
