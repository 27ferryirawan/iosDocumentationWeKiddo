//
//  ClassroomChildCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 03/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class ClassroomChildCell: UICollectionViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userStatusImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    var detailObj: ClassroomListStudentModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let obj = detailObj else { return }
        userName.text = obj.child_name
        userImage.sd_setImage(
            with: URL(string: (obj.child_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
    }
}
