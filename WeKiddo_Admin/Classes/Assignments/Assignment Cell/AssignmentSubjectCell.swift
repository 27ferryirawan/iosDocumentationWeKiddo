//
//  AssignmentSubjectCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 20/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AssignmentListCellDelegate: class {
    func goToDetail()
}

class AssignmentSubjectCell: UITableViewCell {

    @IBOutlet weak var classLbl: UILabel!
    @IBOutlet weak var contentCellButton: UIButton!
    @IBOutlet weak var assignmentDateMonth: UILabel!
    @IBOutlet weak var assignmentDateDay: UILabel!
    @IBOutlet weak var assignmentDateNumber: UILabel!
    @IBOutlet weak var assignmentSubjectTopic: UILabel!
    @IBOutlet weak var assignmentContent: UILabel!
    @IBOutlet weak var assignmentList: UIView!{
        didSet{
            assignmentList.setBorderShadow(color: UIColor.gray, shadowRadius: 5, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    var assignmentObjc: AssignmentContentModel? {
        didSet {
            cellDataSet()
        }
    }
    weak var delegate: AssignmentListCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        contentCellButton.addTarget(self, action: #selector(goToDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func goToDetail() {
        guard let obj = assignmentObjc else { return }
        ACRequest.POST_ASSIGNMENT_DETAIL(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, assignID: obj.assignment_id, classID: obj.school_class_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (assignmentDetailData) in
            ACData.ASSIGNMENTDETAILDATA = assignmentDetailData
            SVProgressHUD.dismiss()
            self.delegate?.goToDetail()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func cellDataSet() {
        guard let obj = assignmentObjc else { return }
        assignmentContent.text = obj.subject_name
        assignmentSubjectTopic.text = obj.chapter_name
        assignmentDateNumber.text = "\(getDay(time: obj.due_date))"
        assignmentDateMonth.text = "\(getMonth(time: obj.due_date))"
        assignmentDateDay.text = "\(getWeekDay(time: obj.due_date))"
        classLbl.text = obj.school_class
    }
    
}

extension AssignmentSubjectCell {
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
        dateFormatterResult.dateFormat = "LLL"
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
