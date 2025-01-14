//  Created by Melnykov Valerii on 14.07.2023
//


import UIKit

class ReusableCellPoeTTT: UICollectionViewCell {
    
    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var titleContainer: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var height: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    func setupCell() {
        cellLabel.textColor = .white
        
        contentContainer.layer.cornerRadius = 8
        titleContainer.layer.cornerRadius = 8
        
        cellImage.layer.cornerRadius = 8
        cellImage.layer.borderColor = UIColor.black.cgColor
        cellImage.layer.borderWidth = 2
    }
}
