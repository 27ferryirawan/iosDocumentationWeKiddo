//
//  TableViewCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 15/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage
import ActionSheetPicker_3_0
import SVProgressHUD

protocol HomeHeaderDelegate: class {
    func goToAttendance()
    func reloadDataBasedOnSelectedChild()
    func toDetailSession()
}

class TableViewCell: UITableViewCell {
    var delegate: HomeHeaderDelegate?
    var students: [String] = []
    @IBOutlet weak var studentPicker: UIButton!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var currentSession: UILabel!
    @IBOutlet weak var currentSessionTime: UILabel!
    @IBOutlet weak var currentSessionButton: UIButton!
    var childObj: [ChildModel]? {
        didSet {
            childDataSet()
        }
    }
    var userObjc: HomeGeneralDataModel? {
        didSet{
            cellDataSet()
        }
    }
    @IBOutlet weak var viewSchool: UIView! {
        didSet {
            viewSchool.layer.borderColor = UIColor.gray.cgColor
            viewSchool.layer.borderWidth = 0.5
            viewSchool.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var viewCurrentSession: UIView! {
        didSet {
            viewCurrentSession.layer.borderColor = UIColor.gray.cgColor
            viewCurrentSession.layer.borderWidth = 1
            viewCurrentSession.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var seeAttendanceButton: UIButton! {
        didSet {
            seeAttendanceButton.layer.cornerRadius = 5
            seeAttendanceButton.clipsToBounds = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        currentSessionButton.addTarget(self, action: #selector(toCurrentSession), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func phoneAction(_ sender: UIButton) {
        guard let obj = userObjc else {
            return
        }
        if let url = URL(string: "tel://\(obj.homeProfile_teacher_phone)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    @objc func toCurrentSession() {
        guard let obj = userObjc else {
            return
        }
        print(obj.session_id)
        ACRequest.GET_SESSION_DETAIL(subjectSessionId: obj.session_id, successCompletion: { (sessionDetail) in
            ACData.SESSIONDETAIL = sessionDetail
            SVProgressHUD.dismiss()
            self.delegate?.toDetailSession()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func childDataSet() {
        students.removeAll()
        for value in childObj! {
            students.append(value.child_name)
        }
        self.studentPicker.addTarget(self, action: #selector(showStudentsPicker), for: .touchUpInside)
    }
    func cellDataSet() {
        guard let name = userObjc?.homeProfile_child_name, let schoolName = userObjc?.homeProfile_school_name, let className = userObjc?.homeProfile_class, let teacherName = userObjc?.homeProfile_teacher_name, let sessionSubject = userObjc?.session_subjetName, let userImage = userObjc?.homeProfile_child_image, let sessionStart = userObjc?.session_start, let sessionEnd = userObjc?.session_end else {
            return
        }
        self.nameLabel.text = name
        self.schoolNameLabel.text = schoolName
        self.classLabel.text = className
        self.teacherNameLabel.text = teacherName
        self.currentSession.text = sessionSubject
        self.currentSessionTime.text = "\(toDateString(time: sessionStart)) - \(toDateString(time: sessionEnd)) AM"
        self.avatarImage?.sd_setImage(
            with: URL(string: userImage),
            placeholderImage: UIImage(named: "icon_wekiddo"),
            options: .refreshCached
        )
        self.seeAttendanceButton.addTarget(self, action: #selector(seeAttendance), for: .touchUpInside)
    }
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
    @objc func showStudentsPicker() {
        ActionSheetStringPicker.show(
            withTitle: "Select Your Kids",
            rows: students,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let studentID = self.childObj![indexes].child_id, let studentName = values else {
                    return
                }
                print(studentID)
                print(studentName)
                self.getChildData(studentID: studentID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    func getChildData(studentID: String) {
        ACData.TABBARMENUDATA.removeAll()
        ACData.ASSIGNMENT.removeAll()
        ACData.ANNOUNCEMENT.removeAll()
        ACData.SESSIONS.removeAll()
        ACData.NEWSCONTENT.removeAll()
        ACData.EXAMDATA.removeAll()
        ACData.COURSELISTDATA.removeAll()
        ACRequest.GET_HOME_DATA(childID: studentID, successCompletion: { (homeData, currentSessionData, assignmentData, announcementData, sessionData, newsData, examData, coursesData, tabbarData) in
            ACData.HOMEDATA = homeData
            ACData.CURRENTSESSIONDATA = currentSessionData
            ACData.ASSIGNMENT = assignmentData
            ACData.ANNOUNCEMENT = announcementData
            ACData.SESSIONS = sessionData
            ACData.NEWSCONTENT = newsData
            ACData.COURSELISTDATA = coursesData
            ACData.EXAMDATA = examData

            if ACData.TABBARMENUDATA.count > 0 {
                ACData.TABBARMENUDATA.removeAll()
            } else {
                ACData.TABBARMENUDATA = tabbarData
            }
            
            SVProgressHUD.dismiss()
            self.updateTabMenu()
//            appDelegate?.goToHome()
        }, failCompletion: { (message) in
            SVProgressHUD.dismiss()
//            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
//            }))
//            self.present(alert, animated: true)
        })
    }
    func updateTabMenu() {
        self.delegate?.reloadDataBasedOnSelectedChild()
    }
    @objc func seeAttendance() {
        self.delegate?.goToAttendance()
    }
}
