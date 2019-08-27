//
//  CourseDetailCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 24/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class CourseDetailCell: UITableViewCell {
    @IBOutlet weak var contentDesc: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    var courseObj: CourseDetailModel? {
        didSet {
            cellDataSet()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellDataSet() {
        guard let object = courseObj else {
            return
        }
        contentImage.sd_setImage(
            with: URL(string: "\(object.course_image)"),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        contentDesc.text = object.course_desc
    }
}
