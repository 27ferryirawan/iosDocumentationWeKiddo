//
//  DashboardAssignmentContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

protocol DashboardAssignmentContentCellDelegate: class {
    func toAssignmentList()
    func toEbookUploadList()
    func toEbookDownloadList()
    func toExerciseSchoolCreate(withSchoolID: String)
    func toExerciseStudentDo()
}

class DashboardAssignmentContentCell: UITableViewCell {

    @IBOutlet weak var statusView: UIView! {
        didSet {
            statusView.layer.cornerRadius = statusView.frame.size.width / 2
            statusView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var rightTotalLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftTotalLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var submissionPercentLabel: UILabel!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var schoolImage: UIImageView!
    
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var rightView: UIView! {
        didSet {
            rightView.layer.borderColor = UIColor.lightGray.cgColor
            rightView.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var leftView: UIView! {
        didSet {
            leftView.layer.borderColor = UIColor.lightGray.cgColor
            leftView.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var statisticView: UIView! {
        didSet {
            statisticView.layer.cornerRadius = 5.0
            statisticView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 1.0
            bgView.layer.cornerRadius = 5.0
            bgView.layer.masksToBounds = true
        }
    }
    
    weak var delegate: DashboardAssignmentContentCellDelegate?
    
    var detailAssignmentObj: DashboardCoordinatorAssignmentListModel? {
        didSet {
            cellConfig()
        }
    }
    
    var detailEbookObj: DashboardCoordinatorEbookListModel? {
        didSet {
            cellEbookConfig()
        }
    }
    
    var detailExerciseObj: DashboardCoordinatorExerciseListModel? {
        didSet {
            cellExerciseConfig()
        }
    }
    
    var isAssignment = Bool()
    var isEbook = Bool()
    var isExercise = Bool()
    var currentDate = ""
    var yearID = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func leftAction(_ sender: UIButton) {
        if isAssignment {
            ACData.COORDINATORASSIGNMENTLISTPERSCHOOL.removeAll()
            guard let obj = detailAssignmentObj else { return }
            ACRequest.POST_ASSIGNMENT_LIST_PER_SCHOOL(userId: ACData.LOGINDATA.userID, date: currentDate, yearID: yearID, schoolID: obj.school_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
                SVProgressHUD.dismiss()
                ACData.COORDINATORASSIGNMENTLISTPERSCHOOL = results
                self.delegate?.toAssignmentList()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else if isEbook {
            ACData.COORDINATOREBOOKUPLOADLISTDATA.removeAll()
            guard let obj = detailEbookObj else { return }
            ACRequest.POST_EBOOK_UPLOAD_LIST(userId: ACData.LOGINDATA.userID, schoolID: obj.school_id, yearID: yearID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
                SVProgressHUD.dismiss()
                ACData.COORDINATOREBOOKUPLOADLISTDATA = results
                self.delegate?.toEbookUploadList()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else {
            ACData.COORDINATOREXERCISESCHOOLCREATEDATA.removeAll()
            guard let obj = detailExerciseObj else { return }
            ACRequest.POST_EXERCISE_SCHOOL_CREATE_LIST(userId: ACData.LOGINDATA.userID, schoolID: obj.school_id, yearID: yearID, exerciseID: 1, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
                SVProgressHUD.dismiss()
                ACData.COORDINATOREXERCISESCHOOLCREATEDATA = results
                self.delegate?.toExerciseSchoolCreate(withSchoolID: obj.school_id)
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        }
    }
    
    @IBAction func rightAction(_ sender: UIButton) {
        if isAssignment {
            ACData.COORDINATORASSIGNMENTLISTPERSCHOOL.removeAll()
            guard let obj = detailAssignmentObj else { return }
            ACRequest.POST_ASSIGNMENT_LIST_PER_SCHOOL(userId: ACData.LOGINDATA.userID, date: currentDate, yearID: yearID, schoolID: obj.school_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
                SVProgressHUD.dismiss()
                ACData.COORDINATORASSIGNMENTLISTPERSCHOOL = results
                self.delegate?.toAssignmentList()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else if isEbook {
            ACData.COORDINATOREBOOKDOWNLOADLISTDATA.removeAll()
            guard let obj = detailEbookObj else { return }
            ACRequest.POST_EBOOK_DOWNLOAD_LIST(userId: ACData.LOGINDATA.userID, schoolID: obj.school_id, yearID: yearID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
                SVProgressHUD.dismiss()
                ACData.COORDINATOREBOOKDOWNLOADLISTDATA = results
                self.delegate?.toEbookDownloadList()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else {
            guard let obj = detailExerciseObj else { return }
            ACRequest.POST_EXERCISE_STUDENT_DO_EXERCISE_LIST(userId: ACData.LOGINDATA.userID, schoolID: obj.school_id, yearID: yearID, exerciseID: 1, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
                SVProgressHUD.dismiss()
                ACData.COORDINATORSTUDENTDOEXERCISELISTDATA = result
                self.delegate?.toExerciseStudentDo()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        }
    }
    
    func cellConfig() {
        guard let obj = detailAssignmentObj else { return }
        self.schoolImage.sd_setImage(
            with: URL(string: (obj.school_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        schoolName.text = obj.school_name
        submissionPercentLabel.text = "Submission : \(obj.weekly_statistic_submission)%"
        leftLabel.text = "Average Assignment (by Student)"
        leftTotalLabel.text = "\(obj.avg_assignment)"
        rightLabel.text = "Worksheet Submission"
        rightTotalLabel.text = "\(obj.worksheet_submission)"
        if obj.status == 1 {
            statusView.backgroundColor = .green
        } else if obj.status == 2 {
            statusView.backgroundColor = .orange
        } else {
            statusView.backgroundColor = .blue
        }
    }
    
    func cellEbookConfig() {
        guard let obj = detailEbookObj else { return }
        self.schoolImage.sd_setImage(
            with: URL(string: (obj.school_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        schoolName.text = obj.school_name
        submissionPercentLabel.text = "Book Download : \(obj.weekly_statistic_book_download)%"
        leftLabel.text = "Total Book Upload"
        leftTotalLabel.text = "\(obj.total_book_upd)"
        rightLabel.text = "Total Student Download"
        rightTotalLabel.text = "\(obj.total_student_download)"
        if obj.status == 1 {
            statusView.backgroundColor = .green
        } else if obj.status == 2 {
            statusView.backgroundColor = .orange
        } else {
            statusView.backgroundColor = .blue
        }
    }
    
    func cellExerciseConfig() {
        guard let obj = detailExerciseObj else { return }
        self.schoolImage.sd_setImage(
            with: URL(string: (obj.school_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        schoolName.text = obj.school_name
        submissionPercentLabel.text = "Total Students Do Exercise : \(obj.weekly_statistic_total_student_do_exercise)%"
        leftLabel.text = "School Create Exercise"
        leftTotalLabel.text = "\(obj.school_create_exercise)"
        rightLabel.text = "Total Students Do Exercise"
        rightTotalLabel.text = "\(obj.total_student_do_exercise)"
        if obj.status == 1 {
            statusView.backgroundColor = .green
        } else if obj.status == 2 {
            statusView.backgroundColor = .orange
        } else {
            statusView.backgroundColor = .blue
        }
    }
    
}
