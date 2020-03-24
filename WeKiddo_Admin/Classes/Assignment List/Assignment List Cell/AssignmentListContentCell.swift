//
//  AssignmentListContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AssignmentListContentCellDelegate: class {
    func toDetailWorksheet()
}

class AssignmentListContentCell: UITableViewCell {

    @IBOutlet weak var contentDescLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var subjectNameLabel: UILabel!
    @IBOutlet weak var subjectCountLabel: UILabel!
    @IBOutlet weak var subjectAndDateLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    weak var delegate: AssignmentListContentCellDelegate?
    
    var detailObj: CoordinatorAssignmentListDataPerSchool? {
        didSet {
            cellConfig()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfig() {
        guard let obj = detailObj else { return }
        subjectAndDateLabel.text = "\(obj.subject_topic_name) | \(convertTime(time: obj.quiz_start_datetime)) - \(convertTime(time: obj.quiz_end_datetime))"
        subjectCountLabel.text = "\(obj.total_student_assignment)/\(obj.total_student_assignment_submission)"
        subjectNameLabel.text = obj.subject_name
        userName.text = obj.teacher_name
        contentDescLabel.text = obj.note
    }
    
    @IBAction func detailButton(_ sender: UIButton) {
        guard let obj = detailObj, let yearID = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else { return }
        ACRequest.POST_ASSIGNMENT_LIST_PER_CLASS(userId: ACData.LOGINDATA.userID, schoolClassID: obj.school_class_id, yearID: yearID, assignmentID: obj.assignment_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            SVProgressHUD.dismiss()
            ACData.COORDINATORASSIGNMENTLISTPERCLASS = results
            self.delegate?.toDetailWorksheet()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    
}

extension AssignmentListContentCell {
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
