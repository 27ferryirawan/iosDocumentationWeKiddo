//
//  TotalSchoolHeaderView.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

class TotalSchoolHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.cornerRadius = 5.0
            bgView.layer.masksToBounds = true
            bgView.layer.borderWidth = 1.0
            bgView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
}
