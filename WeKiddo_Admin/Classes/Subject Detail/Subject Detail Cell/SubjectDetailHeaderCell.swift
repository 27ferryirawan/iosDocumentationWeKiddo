//
//  SubjectDetailHeaderCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 11/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol SubjectDetailHeaderCellDelegate: class {
    func toSearchPage()
}

class SubjectDetailHeaderCell: UITableViewCell {

    @IBOutlet weak var subjectTeacherImage: UIImageView!
    @IBOutlet weak var subjectTeacher: UILabel!
    @IBOutlet weak var subjectTopic: UILabel!
    weak var delegate: SubjectDetailHeaderCellDelegate?
    var detailObj: SubjectDetailModel? {
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
        subjectTopic.text = obj.teacher_info_subject_name
        subjectTeacher.text = obj.teacher_info_teacher_name
    }
    @IBAction func toSearchPage(_ sender: UIButton) {
        self.delegate?.toSearchPage()
    }
}
