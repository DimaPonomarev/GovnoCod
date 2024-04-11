

import UIKit

class EditBlueItemCollectionViewCell: UICollectionViewCell {
    
  
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        struct DefaultStruct {
            static let noname = "string"
        }
        self.layer.cornerRadius = 10
    }
 
    override func prepareForReuse() {
        super.prepareForReuse()
        struct DefaultStruct {
            static let noname = "string"
        }
        cellImage.image = nil
    }
    
    func lets_zetupkaTsell(_ data: EditorItemRealmModelElement) {
        struct DefaultStruct {
            static let noname = "string"
        }
        cellImage.image = nil
        if data.imageData.count == 0 {
            DropBoxBeautifulManager.shared.getBloodyImageURLFromDropBox(img: data.imagePath) { urlString in
                if let urlString = urlString {
                    self.cellImage.lets_setupBloodyImages(from: urlString, mod: nil, category: nil, editorItem: data, type: .editorItems)
                }
            }
        } else {
            cellImage.image = UIImage(data: data.imageData)
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            titleLabel.font = UIFont(name: "VT323-Regular", size: 30)
        } else {
            titleLabel.font = UIFont(name: "VT323-Regular", size: 20)
        }
        
        titleLabel.text = data.category.uppercased()
        
    }
    
    func lets_setupkaTsellLocal(_ data: EditorItemLocalRealmModelElement) {
        struct DefaultStruct {
            static let noname = "string"
        }
        if data.imageData.count == 0 {
            
        } else {
            cellImage.image = UIImage(data: data.imageData)
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            titleLabel.font = UIFont(name: "VT323-Regular", size: 30)
        } else {
            titleLabel.font = UIFont(name: "VT323-Regular", size: 20)
        }

        titleLabel.text = data.name.uppercased()
    }
}
