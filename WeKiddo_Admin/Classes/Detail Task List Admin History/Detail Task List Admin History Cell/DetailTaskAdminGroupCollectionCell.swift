//
//  DetailTaskAdminGroupCollectionCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 02/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class DetailTaskAdminGroupCollectionCell: UICollectionViewCell {

    @IBOutlet weak var adminName: UILabel!
    @IBOutlet weak var adminView: UIView! {
        didSet {
            adminView.layer.cornerRadius = adminView.frame.size.width / 2
            adminView.layer.masksToBounds = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
