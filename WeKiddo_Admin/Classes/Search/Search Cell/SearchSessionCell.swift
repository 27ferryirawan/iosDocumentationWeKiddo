//
//  SearchSessionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 12/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol SearchAssignmentCellDelegate: class {
    func goToAssignmentDetailPage()
}

class SearchSessionCell: UITableViewCell {

    @IBOutlet weak var dateMonthLabel: UILabel!
    @IBOutlet weak var dateDayLabel: UILabel!
    @IBOutlet weak var dateNumberLabel: UILabel!
    @IBOutlet weak var topicLable: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    var assignmentObjc: SubjectSearchUpcomingAssignment?{
        didSet{
            cellDataSet()
        }
    }
    weak var delegate: SearchAssignmentCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellDataSet() {
        guard let obj = assignmentObjc else {
            return
        }
        subjectLabel.text = obj.subject_name
        topicLable.text = obj.subject_session
        dateNumberLabel.text = "\(getDay(time: obj.assignment_due_date))"
        dateMonthLabel.text = "\(getMonth(time: obj.assignment_due_date))"
        dateDayLabel.text = "\(getWeekDay(time: obj.assignment_due_date))"
    }
    @IBAction func toDetailAssignment(_ sender: UIButton) {
        guard let obj = assignmentObjc else {
            return
        }
        ACRequest.GET_ASSIGNMENT_DETAIL(schoolAssignmentId: obj.school_assignment_id, childID: ACData.HOMEDATA.childID, successCompletion: { (assignmentDetailData) in
            ACData.ASSIGNMENTDETAILDATA = assignmentDetailData
            SVProgressHUD.dismiss()
            self.delegate?.goToAssignmentDetailPage()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}

extension SearchSessionCell {
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
