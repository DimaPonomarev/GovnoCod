

import UIKit

class SettingsBlueCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        struct DefaultStruct {
            static let noname = "string"
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            cellTitle.font = UIFont(name: "VT323-Regular", size: 40)
        } else {
            cellTitle.font = UIFont(name: "VT323-Regular", size: 20)
        }
        cellTitle.textColor = .white
    }
    
    func lets_zetupkaTsell(_ content: ModelForSettingsItem) {
        struct DefaultStruct {
            static let noname = "string"
        }
        cellImage.image = UIImage(named: content.imageName)
        cellTitle.text = content.title.uppercased()
    }
}
