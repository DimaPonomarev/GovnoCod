

import UIKit

class EditModeCollectionViewBlueCell: UICollectionViewCell {
    
    @IBOutlet weak var bckgrndView: UIView!
    @IBOutlet weak var cellTitle: UILabel!
    
    private var gradientLayer: CAGradientLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        struct DefaultStruct {
            static let noname = "string"
        }
        lets_setupUI()
    }
    
    
    private func lets_setupUI() {
        struct DefaultStruct {
            static let noname = "string"
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            cellTitle.font = UIFont(name: "VT323-Regular", size: 40)
        } else {
            cellTitle.font = UIFont(name: "VT323-Regular", size: 20)
        }
        cellTitle.textColor = .white
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    
    func lets_setupGradient() {
        struct DefaultStruct {
            static let noname = "string"
        }
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = bounds
        gradientLayer?.colors = [UIColor(red: 242/255, green: 177/255, blue: 5/255, alpha: 1.0).cgColor,
                                 UIColor(red: 212/255, green: 129/255, blue: 0/255, alpha: 1.0).cgColor]
        gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer?.endPoint = CGPoint(x: 1, y: 1)
        
        if let gradientLayer = gradientLayer {
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    func lets_removeGradient() {
        struct DefaultStruct {
            static let noname = "string"
        }
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = nil
    }
}
