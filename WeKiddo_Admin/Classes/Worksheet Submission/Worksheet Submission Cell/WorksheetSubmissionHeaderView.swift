//
//  WorksheetSubmissionHeaderView.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

class WorksheetSubmissionHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var classView: UIView! {
        didSet {
            classView.layer.cornerRadius = 5.0
            classView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var subjectCountLabel: UILabel!
    @IBOutlet weak var subjectNameLabel: UILabel!
    @IBOutlet weak var subjectAndDateLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 1.0
        }
    }
    
    var detailObj: CoordinatorAssignmentListPerClass? {
        didSet {
            cellConfig()
        }
    }
    
    func cellConfig() {
        guard let obj = detailObj else { return }
        subjectAndDateLabel.text = "\(obj.subject_topic_name) | \(convertTime(time: obj.quiz_start_datetime)) - \(convertTime(time: obj.quiz_end_datetime))"
        subjectNameLabel.text = obj.subject_name
        subjectCountLabel.text = "\(obj.total_student_assignment)/\(obj.total_student_assignment_submission)"
        classLabel.text = obj.school_class
    }

}

extension WorksheetSubmissionHeaderView {
    func convertTime(time: String) -> String {
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
        dateFormatterResult.dateFormat = "HH:mm"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
