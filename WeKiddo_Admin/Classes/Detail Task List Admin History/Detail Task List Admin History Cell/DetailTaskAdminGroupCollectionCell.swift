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
    var detailObj: DetailTaskAdminAssigneeMemberModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        adminName.text = obj.admin_pos_name
    }
}
