//
//  MenuCollectionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 18/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class MenuCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var menuBadge: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configCell(index: Int) {
        switch index {
        case 0:
            menuImage.image = UIImage(named: "ic_home_approval")
            menuLabel.text = "APPROVAL"
            menuBadge.text = "(\(ACData.HOMEDATA.approval_count))"
        case 1:
            menuImage.image = UIImage(named: "ic_home_permission")
            menuLabel.text = "PERMISSIONS"
            menuBadge.text = "(\(ACData.HOMEDATA.permission_count))"
        case 2:
            menuLabel.text = "QUESTION"
            menuBadge.text = "(\(ACData.HOMEDATA.permission_count))"
        default:
            return
        }
    }
}
