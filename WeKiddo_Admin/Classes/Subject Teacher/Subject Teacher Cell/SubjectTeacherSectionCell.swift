//
//  SubjectTeacherSectionCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 12/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SubjectTeacherSectionCell: UITableViewCell {

    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 0.5
        }
    }
    var detailObj: SubjectTopicBySubjectModel? {
        didSet {
            cellConfig()
        }
    }
    var detailClassObj: SubjectTopicByClassModel? {
        didSet {
            cellConfigClass()
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
        sectionLabel.text = obj.subject_name
    }
    func cellConfigClass() {
        guard let obj = detailClassObj else { return }
        sectionLabel.text = obj.school_level
    }
}
