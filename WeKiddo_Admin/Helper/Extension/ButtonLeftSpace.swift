//
//  TextFieldSpace.swift
//  WeKiddo
//
//  Created by Ferry Irawan on 21/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import UIKit
class ButtonLeftSpace : UIButton {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
