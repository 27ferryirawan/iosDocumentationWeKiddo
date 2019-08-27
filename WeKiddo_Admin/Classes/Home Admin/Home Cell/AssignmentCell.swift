//
//  AssignmentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AssignmentContentDelegate: class {
    func goToAssignmentDetailPage()
}

class AssignmentCell: UITableViewCell {
    @IBOutlet weak var contentCellButton: UIButton!
    @IBOutlet weak var assignmentDateMonth: UILabel!
    @IBOutlet weak var assignmentDateDay: UILabel!
    @IBOutlet weak var assignmentDateNumber: UILabel!
    @IBOutlet weak var assignmentSubjectTopic: UILabel!
    @IBOutlet weak var assignmentContent: UILabel!
    var assignmentObjc: AssignmentModel?{
        didSet{
            cellDataSet()
        }
    }
    weak var delegate: AssignmentContentDelegate? = nil
    @IBOutlet weak var assignmentList: UIView! {
        didSet {
            assignmentList.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        contentCellButton.addTarget(self, action: #selector(goToDetail), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func goToDetail() {
        print("agasadag")
//        ACRequest.GET_ASSIGNMENT_DETAIL(schoolAssignmentId: assignmentObjc!.school_assignment_id, childID: ACData.HOMEDATA.childID, successCompletion: { (assignmentDetailData) in
//            ACData.ASSIGNMENTDETAILDATA = assignmentDetailData
//            SVProgressHUD.dismiss()
//            self.delegate?.goToAssignmentDetailPage()
//        }) { (message) in
//            SVProgressHUD.dismiss()
//        }
    }
    func cellDataSet() {
//        guard let subjectContent = assignmentObjc?.subject_name, let subjectSession = assignmentObjc?.subject_session, let subjectDate = assignmentObjc?.assignment_due_date else {
//            return
//        }
//        assignmentContent.text = subjectContent
//        assignmentSubjectTopic.text = subjectSession
//        assignmentDateNumber.text = "\(getDay(time: subjectDate))"
//        assignmentDateMonth.text = "\(getMonth(time: subjectDate))"
//        assignmentDateDay.text = "\(getWeekDay(time: subjectDate))"
    }
    
    func getMonth(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
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
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
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
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
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
