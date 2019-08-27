//
//  TeacherApprovalViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 01/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class TeacherApprovalViewController: UIViewController {

    var status = ""
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var centerView: UIView! {
        didSet {
            centerView.layer.cornerRadius = centerView.frame.size.width / 2
            centerView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var headerView: UIView! {
        didSet {
            headerView.setBorderShadow(color:  UIColor.gray, shadowRadius: 1.0, shadowOpactiy: 1, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        populateData()
        configView()
        updateView()
    }
    func configNavigation() {
        detectAdaptiveClass()
            backStyleNavigationController(pageTitle: "Teacher Approval", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func populateData() {
        guard let obj = ACData.ATTENDANCEDETAILDATA else { return }
        classLabel.text = obj.school_class
        dateLabel.text = "\(getWeekDay(time: obj.session_date)) - \(getMonth(time: obj.session_date))"
        subjectLabel.text = "\(obj.subject_name) - \(obj.chapter_name)"
        topicLabel.text = obj.chapter_desc
        timeLabel.text = "\(toDateString(time: obj.start_time)) - \(toDateString(time: obj.end_time))"
        teacherLabel.text = obj.teacher_name
    }
    func updateView() {
        if status == "success" {
            self.statusLabel.text = "Thank you for your approval"
        } else {
            self.statusLabel.text = "Please tap your device to RFID to confirm your approval"
        }
    }
    func configView() {
        approveButton.addTarget(self, action: #selector(confirmAttendanceAction), for: .touchUpInside)
    }
    @objc func confirmAttendanceAction() {
        guard let obj = ACData.ATTENDANCEDETAILDATA else { return }
        ACRequest.POST_CONFIRM_CLASS_ATTENDANCE(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolSessionId: obj.school_session_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (message) in
            self.status = message
            SVProgressHUD.dismiss()
            self.updateView()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}

extension TeacherApprovalViewController {
    func getMonth(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "dd MM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
    
    func getWeekDay(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "EEEE"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
    
    func toDateString(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm:ss"
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
