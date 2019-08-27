//
//  CustomBorderShadow.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 04/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//


import UIKit

extension UIView {
    
    func setBorderShadow(color:UIColor, shadowRadius:Float, shadowOpactiy:Float, shadowOffsetWidth:Int, shadowOffsetHeight:Int) {
        self.layer.shadowColor = color.cgColor//UIColor.gray.cgColor
        self.layer.shadowRadius = CGFloat(shadowRadius)//5
        self.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)//CGSize(width: 3.0, height: 3.0)
        self.layer.shadowOpacity = shadowOpactiy//1
    }
    
}
