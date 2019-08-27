//
//  Border+View.swift
//  AYO CLEAN
//
//  Created by Zein Rezky Chandra on 18/05/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class Border_View: UIView {
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height-width, width: self.bounds.size.width, height: self.frame.size.height)
        border.borderWidth = width
    }
}
