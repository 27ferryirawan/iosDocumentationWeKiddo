//
//  MoreCoursesCollectionCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 26/10/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class MoreCoursesCollectionCell: UICollectionViewCell {

    @IBOutlet weak var contentDistanceLabel: UILabel!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    var detailObj: NearbyCourseMoreModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        contentImage.sd_setImage(
            with: URL(string: obj.course_image),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        contentTitleLabel.text = obj.course_name
        contentDistanceLabel.text = "\(obj.kilometers) Km"
    }
}
