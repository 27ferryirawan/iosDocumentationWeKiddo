//
//  ScheduleCourceCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 17/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol ScheduleCourseDelegate: class {
    func goToSessionDetail()
}

class ScheduleCourceCell: UITableViewCell {

    @IBOutlet weak var sessionButton: UIButton!
    @IBOutlet weak var sessionBackgroundColor: UIView!{
        didSet{
            sessionBackgroundColor.setBorderShadow(color: ACColor.DARK_SHADOW, shadowRadius: 7, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    @IBOutlet weak var sessionDate: UILabel!
    @IBOutlet weak var sessionSubject: UILabel!
    var isCourse: Bool?
    var courseObjc: CourseListModel?{
        didSet{
            cellDataSet(isSchedule: false)
        }
    }
    var sessionObjc: SessionsModel?{
        didSet{
            cellDataSet(isSchedule: true)
        }
    }
    weak var delegate: ScheduleCourseDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        sessionButton.addTarget(self, action: #selector(goToSessionDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func goToSessionDetail() {
        guard let obj = sessionObjc else {
            return
        }
        ACRequest.GET_SESSION_DETAIL(subjectSessionId: obj.school_class_session_id, successCompletion: { (sessionDetail) in
            ACData.SESSIONDETAIL = sessionDetail
            SVProgressHUD.dismiss()
            self.delegate?.goToSessionDetail()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func cellDataSet(isSchedule: Bool) {
        if isSchedule {
            guard let timeStart = sessionObjc?.class_session_start, let timeEnd = sessionObjc?.class_session_end, let subject = sessionObjc?.subject_name else {
                return
            }
            sessionDate.text = "\(toDateString(time: timeStart)) - \(toDateString(time: timeEnd)) AM"
            sessionSubject.text = subject
        } else {
            guard let timeStart = courseObjc?.course_session_start, let timeEnd = courseObjc?.course_session_end, let subject = courseObjc?.course_session_name else {
                return
            }
            sessionDate.text = "\(toDateString(time: timeStart)) - \(toDateString(time: timeEnd)) AM"
            sessionSubject.text = subject
        }
    }
}

extension ScheduleCourceCell {
    func toDateString(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-mm-dd hh:mm:ss"
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
