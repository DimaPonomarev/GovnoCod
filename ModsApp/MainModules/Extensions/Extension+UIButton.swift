//
//  Extension+UIButton.swift
//  ModsApp
//
//  Created by Дмитрий Пономарев on 06.11.2023.
//

import UIKit

extension UIView {
    
    func makeButtonWithInnerShadow() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.backgroundColor = UIColor(red: 0.150, green: 0.145, blue: 0.3745, alpha: 1)
        makeInnerShadow()
    }
    
    private func makeInnerShadow() {
        let innerShadowLayer = CALayer()
        innerShadowLayer.frame = self.bounds
        
        let cornerRadius = self.layer.cornerRadius
        let path = UIBezierPath(roundedRect: innerShadowLayer.bounds.insetBy(dx: -20, dy: -20), cornerRadius: cornerRadius)
        let innerPart = UIBezierPath(roundedRect: innerShadowLayer.bounds, cornerRadius: cornerRadius).reversing()
        
        path.append(innerPart)
        innerShadowLayer.shadowPath = path.cgPath
        innerShadowLayer.masksToBounds = true
        innerShadowLayer.shadowColor = UIColor.white.cgColor
        innerShadowLayer.shadowOffset = CGSize.zero
        innerShadowLayer.shadowOpacity = 1
        innerShadowLayer.shadowRadius = 5
        self.layer.addSublayer(innerShadowLayer)
    }
    
    func addSmallImageWithName(_ name: String) {
        let image = UIImage(named: name)
        let imageView = UIImageView(image: image)
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
            $0.height.equalToSuperview().inset(10)
            $0.width.equalTo(imageView.snp.height)
        }
    }
    
    func addFullSizeImageWithName(_ name: String) {
        let image = UIImage(named: name)
        let imageView = UIImageView(image: image)
        self.addSubview(imageView)
        self.backgroundColor = .clear
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func addLabelOnView(label: UILabel) {
        self.addSubview(label)
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
