//
//  CustomLineView.swift
//  ModsApp
//
//  Created by Дмитрий Пономарев on 08.11.2023.
//

import UIKit

class CustomLineView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 200, y: 400))
        path.addLine(to: CGPoint(x: 250, y: 50))
        
        UIColor.green.setStroke()
        path.stroke() 
    }
}
