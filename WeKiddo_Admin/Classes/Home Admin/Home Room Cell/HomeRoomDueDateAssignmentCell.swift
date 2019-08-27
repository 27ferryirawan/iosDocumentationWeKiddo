//
//  HomeRoomDueDateAssignmentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol HomeRoomDueDateAssignmentCellDelegate: class {
    func toDetailAssignment()
}

class HomeRoomDueDateAssignmentCell: UITableViewCell {

    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var dateMonthLabel: UILabel!
    @IBOutlet weak var dateDayLabel: UILabel!
    @IBOutlet weak var dateNumberLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    var assignObj: DashboardModelAssignment? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: HomeRoomDueDateAssignmentCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        contentButton.addTarget(self, action: #selector(fetchDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func fetchDetail() {
        guard let obj = assignObj else { return }
        ACRequest.POST_ASSIGNMENT_DETAIL(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, assignID: obj.assignment_id, classID: obj.school_class_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (assignmentDetailData) in
            ACData.ASSIGNMENTDETAILDATA = assignmentDetailData
            SVProgressHUD.dismiss()
            self.delegate?.toDetailAssignment()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func cellConfig() {
        guard let obj = assignObj else { return }
        subjectLabel.text = obj.subject_name
        topicLabel.text = obj.subject_session
//        classLabel.text = obj.
        dateNumberLabel.text = "\(getDay(time: obj.assignment_due_date))"
        dateMonthLabel.text = "\(getMonth(time: obj.assignment_due_date))"
        dateDayLabel.text = "\(getWeekDay(time: obj.assignment_due_date))"
    }
}

extension HomeRoomDueDateAssignmentCell {
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
        dateFormatterResult.dateFormat = "LLLL"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
    
    func getDay(time: String) -> String {
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
        dateFormatterResult.dateFormat = "dd"
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
        dateFormatterResult.dateFormat = "EEE"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
