//
//  ACScrollViewExtension.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 15/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

extension UIScrollView {
    /// Sets content offset to the top.
    func resetScrollPositionToTop() {
        self.contentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top)
    }
}
