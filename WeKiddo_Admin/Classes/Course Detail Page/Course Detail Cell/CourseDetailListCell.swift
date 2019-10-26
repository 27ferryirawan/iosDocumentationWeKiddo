//
//  CourseDetailListCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 26/10/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class CourseDetailListCell: UITableViewCell {

    @IBOutlet weak var courseDesc: UILabel!
    @IBOutlet weak var courseTitle: UILabel!
    var detailObj: CourseDetailListModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else {
            return
        }
        courseTitle.text = obj.course_list_name
        courseDesc.text = obj.course_list_desc
    }
}
