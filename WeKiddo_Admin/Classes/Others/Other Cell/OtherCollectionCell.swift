//
//  OtherCollectionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 13/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class OtherCollectionCell: UICollectionViewCell {

    @IBOutlet weak var featuredLabel: UILabel!
    @IBOutlet weak var featuredImage: UIImageView!
    var imageIconOthers = [
                        "69": "ic_announcment",
                        "68": "ic_assignment",
                        "70": "ic_examSch",
                        "72": "MONITORING",
                        "58": "user",
                        "59": "user-school",
                        "60": "class-room",
                        "61": "ticket",
                        "62": "SOP",
                        "63": "TASK-LIST"
                    ]
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configCell(index: Int) {
        let menu = ACData.LOGINDATA.dashboardCategoryFeature[index].menu_id
        guard let imageName = imageIconOthers["\(menu)"] else {
            return
        }
        featuredImage.image = UIImage(named: imageName)
        featuredLabel.text = ACData.LOGINDATA.dashboardCategoryFeature[index].menu_name
    }
}
