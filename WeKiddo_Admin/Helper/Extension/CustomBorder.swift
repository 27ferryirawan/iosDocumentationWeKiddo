//
//  CustomBorder.swift
//  AYO CLEAN
//
//  Created by Zein Rezky Chandra on 10/05/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class CustomBorder: CALayer {    
    override func `self`() -> Self {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height-width, width: self.bounds.size.width, height: self.frame.size.height)
        border.borderWidth = width
        return self
    }
}

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
//        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: self.bounds.width, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        self.layer.mask = mask
    }
}
