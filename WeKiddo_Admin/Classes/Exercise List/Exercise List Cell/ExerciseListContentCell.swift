//
//  ExerciseListContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol ExerciseListContentCellDelegate: class {
    func toDetailExercise()
}

class ExerciseListContentCell: UITableViewCell {

    @IBOutlet weak var totalStudentLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var datePeriodLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var detailButton: UIButton!
    
    weak var delegate: ExerciseListContentCellDelegate?
    
    var detailObj: CoordinatorExerciseSchoolCreateDataModel? {
        didSet {
            cellConfig()
        }
    }
    
    var schoolID = ""
    
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
        datePeriodLabel.text = "\(convertDate(time: obj.start_date)) - \(convertDate(time: obj.end_date))"
        nameLabel.text = obj.exercise_name
        userNameLabel.text = obj.teacher_name
        totalStudentLabel.text = "Student \(obj.cnt_student_exercised)"
    }
    
    @IBAction func detailAction(_ sender: UIButton) {
        guard let obj = detailObj, let yearIndexZero = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else { return }
        ACRequest.POST_DETAIL_EXERCISE_SCHOOL_CREATE_LIST(userId: ACData.LOGINDATA.userID, schoolID: schoolID, yearID: yearIndexZero, exerciseID: obj.e_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
            SVProgressHUD.dismiss()
            ACData.DASHBOARDCOORDINATORDETAILSCHOOLCREATEEXERCISEDATA = result
            self.delegate?.toDetailExercise()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    
}

extension ExerciseListContentCell {
    func convertDate(time: String) -> String {
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
        dateFormatterResult.dateFormat = "dd MMMM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
