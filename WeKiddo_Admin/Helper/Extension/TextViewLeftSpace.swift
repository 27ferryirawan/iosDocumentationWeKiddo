//
//  TextViewLeftSpace.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 24/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import UIKit
class TextViewLeftSpace : UITextView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    func setup() {
        textContainerInset = UIEdgeInsets(top: 7, left: 7 , bottom: 7, right: 7)
    }
}
