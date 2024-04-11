

import UIKit

class CategoriesBlueCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.lets_setLinearGradientBackground(startColor: UIColor(red: 0.26, green: 0.25, blue: 0.55, alpha: 1.0),
                                              endColor: UIColor(red: 0.17, green: 0.16, blue: 0.35, alpha: 1.0), radius: 0)
        blurredEffectView?.frame = lockView.bounds
    }
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var lockView: UIView!
    var blurredEffectView: UIVisualEffectView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        struct DefaultStruct {
            static let noname = "string"
        }
        addBlur()
        lockView.isHidden = true
        layer.cornerRadius = 14
        layer.borderWidth = 2
        self.lets_setLinearGradientBackground(startColor: UIColor(red: 0.26, green: 0.25, blue: 0.55, alpha: 1.0),
                                              endColor: UIColor(red: 0.17, green: 0.16, blue: 0.35, alpha: 1.0), radius: 0)
        if UIDevice.current.userInterfaceIdiom == .pad {
            cellTitle.font = UIFont(name: "VT323-Regular", size: 28)
        } else {
            cellTitle.font = UIFont(name: "VT323-Regular", size: 20)
        }
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        struct DefaultStruct {
            static let noname = "string"
        }
        lockView.isHidden = true
        blurredEffectView = nil
        cellImage.image = nil
        cellImage.image = UIImage()
    }
    
    func addBlur() {
        let blurEffect = UIBlurEffect(style: .light) // Можно изменить стиль на .dark или .extraLight
        blurredEffectView = UIVisualEffectView(effect: blurEffect)
        guard let blurredEffectView = blurredEffectView else { return }
//        lockView.addSubview()
        lockView.insertSubview(blurredEffectView, at: 0)
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurredEffectView.leadingAnchor.constraint(equalTo: lockView.leadingAnchor),
            blurredEffectView.trailingAnchor.constraint(equalTo: lockView.trailingAnchor),
            blurredEffectView.topAnchor.constraint(equalTo: lockView.topAnchor),
            blurredEffectView.bottomAnchor.constraint(equalTo: lockView.bottomAnchor)
        ])
    }
    
    func lets_zetupkaTsell(_ data: CategoryRealmModelElement) {
        struct DefaultStruct {
            static let noname = "string"
        }
        cellImage.image = UIImage()
        cellTitle.text = data.categoryName.uppercased()
        if data.categoryImageData.count == 0 {
            DropBoxBeautifulManager.shared.getBloodyImageURLFromDropBox(img: data.categoryImagePath) { urlString in
                if let urlString = urlString {
                    self.cellImage.lets_setupBloodyImages(from: urlString, mod: nil, category: data, editorItem: nil, type: .category)
                }
            }
        } else {
            cellImage.image = UIImage(data: data.categoryImageData)
        }
    }
    
    func making_cellBloodySelected() {
        struct DefaultStruct {
            static let noname = "string"
        }
        layer.borderColor = UIColor(named: "CornflowerBlue")?.cgColor
        cellTitle.textColor = .white
        
    }
    
    func making_cellBloodyDefault() {
        struct DefaultStruct {
            static let noname = "string"
        }
        layer.borderColor = UIColor(named: "CornflowerBlue")?.withAlphaComponent(0.7).cgColor
        cellTitle.textColor = .lightGray
    }
}
