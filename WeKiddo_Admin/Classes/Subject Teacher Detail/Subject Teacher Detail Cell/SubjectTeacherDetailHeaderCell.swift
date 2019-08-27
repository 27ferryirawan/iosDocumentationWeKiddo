//
//  SubjectTeacherDetailHeaderCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 13/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SubjectTeacherDetailHeaderCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    var detailObj: SubjectTeacherDetailModel? {
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
        guard let obj = detailObj else { return }
        topicLabel.text = obj.chapter_name
        descLabel.text = obj.chapter_desc
    }
}
