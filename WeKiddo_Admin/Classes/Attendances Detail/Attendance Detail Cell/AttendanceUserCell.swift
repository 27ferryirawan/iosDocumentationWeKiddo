//
//  AttendanceUserCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 27/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class AttendanceUserCell: UICollectionViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userStatusImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    var detailObj: AttendanceStudentModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let obj = detailObj else { return }
        userName.text = "obj.childName"
        userImage.sd_setImage(
            with: URL(string: (obj.childImage)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
