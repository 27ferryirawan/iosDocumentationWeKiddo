//
//  AdministrationCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 09/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AdministrationCell: UICollectionViewCell {

    @IBOutlet weak var featuredLabel: UILabel!
    @IBOutlet weak var featuredImage: UIImageView!
    var imageIconSettings = ["66":"ic_parent_profile",
                             "67":"ic_logout",
                             "65":"ic_feedback",
                             "64":"ic_language"
                            ]
    var detailObj: DashboardCategoryOthers? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        let menu = obj.menu_id
        guard let imageName = imageIconSettings["\(menu)"] else {
            return
        }
        featuredImage.image = UIImage(named: imageName)
        featuredLabel.text = obj.menu_name
    }
}
