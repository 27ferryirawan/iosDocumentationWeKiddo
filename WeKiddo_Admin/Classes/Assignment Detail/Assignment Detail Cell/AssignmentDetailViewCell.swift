//
//  AssignmentDetailViewCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 07/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class AssignmentDetailViewCell: UITableViewCell {
    @IBOutlet weak var assignmentTypeLabel: UILabel!
    @IBOutlet weak var assignmentTeacherLabel: UILabel!
    @IBOutlet weak var assignmentTopicLabel: UILabel!
    @IBOutlet weak var assignmentDateStartLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var subjectLbl: UIButton!{
        didSet{
            subjectLbl.layer.cornerRadius = 5
            subjectLbl.clipsToBounds = true
        }
    }
    @IBOutlet weak var contentLabel: UILabel! {
        didSet {
            contentLabel.sizeToFit()
        }
    }
    var assignmentObj: AssignmentDetailModel? {
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
        guard let obj = assignmentObj else {
            return
        }
        subjectLbl.setTitle(obj.subject_name, for: .normal)
        contentImage.sd_setImage(
            with: URL(string: (obj.assignment_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        assignmentTopicLabel.text = obj.chapter_name
        assignmentTeacherLabel.text = obj.teacher_name
        assignmentDateStartLabel.text = convertDate(time: obj.created_at)
        contentLabel.text = obj.note
        if obj.assignment_type == "1" {
            assignmentTypeLabel.text = "Homework"
        } else {
            assignmentTypeLabel.text = "Project"
        }
    }
}

extension AssignmentDetailViewCell {
    func convertDate(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "dd MMMM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
