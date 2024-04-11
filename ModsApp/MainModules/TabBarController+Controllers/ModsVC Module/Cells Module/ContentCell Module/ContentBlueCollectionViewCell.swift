
import UIKit

class ContentBlueCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textContainer: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        struct DefaultStruct {
            static let noname = "string"
        }
        cellImage.image = nil
        cellImage.image = UIImage()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        struct DefaultStruct {
            static let noname = "string"
        }
        layer.borderColor = UIColor(named: "CornflowerBlue")?.cgColor
        self.backgroundColor = UIColor(named: "Rhino")
        
        layer.cornerRadius = 14
        textContainer.layer.cornerRadius = 14
        textContainer.layer.maskedCorners = [.layerMaxXMinYCorner]
        if UIDevice.current.userInterfaceIdiom == .pad {
            cellTitle.font = UIFont(name: "VT323-Regular", size: 40)
            cellDescription.font = UIFont(name: "VT323-Regular", size: 28)
        } else {
            cellTitle.font = UIFont(name: "VT323-Regular", size: 30)
            cellDescription.font = UIFont(name: "VT323-Regular", size: 18)
        }
        
        cellDescription.textColor = UIColor.white.withAlphaComponent(0.75)
        cellTitle.textColor = UIColor.white
    }
    
    func lets_setupCellBloodyBlue(_ data: ModRealmModelElement) {
        struct DefaultStruct {
            static let noname = "string"
        }
        cellImage.image = UIImage()
        cellTitle.text = data.modTitle.uppercased()
        cellDescription.text = data.modDescription
        if data.modImageData.count == 0 {
            DropBoxBeautifulManager.shared.getBloodyImageURLFromDropBox(img: data.modImagePath) { urlString in
                if let urlString = urlString {
                    self.cellImage.lets_setupBloodyImages(from: urlString, mod: data, category: nil, editorItem: nil, type: .mods)
                }
            }
        } else {
            cellImage.image = UIImage(data: data.modImageData)
        }
    }
}

