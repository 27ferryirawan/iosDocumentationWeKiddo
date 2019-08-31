//
//  SchoolMonitoringHeaderCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 29/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import ActionSheetPicker_3_0

protocol SchoolMonitoringHeaderCellDelegate: class {
    func refreshData()
}

class SchoolMonitoringHeaderCell: UITableViewCell {
    
    @IBOutlet weak var pendingExamLabel: UILabel!
    @IBOutlet weak var totalExamLabel: UILabel!
    @IBOutlet weak var pendingAnnouncementLabel: UILabel!
    @IBOutlet weak var totalAnnouncementLabel: UILabel!
    @IBOutlet weak var pendingAssignmentLabel: UILabel!
    @IBOutlet weak var totalAssignmentLabel: UILabel!
    @IBOutlet weak var schoolExamView: UIView! {
        didSet {
            schoolExamView.layer.borderColor = UIColor.lightGray.cgColor
            schoolExamView.layer.borderWidth = 1.0
            schoolExamView.layer.cornerRadius = 5.0
            schoolExamView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var schoolAnnouncementView: UIView! {
        didSet {
            schoolAnnouncementView.layer.borderColor = UIColor.lightGray.cgColor
            schoolAnnouncementView.layer.borderWidth = 1.0
            schoolAnnouncementView.layer.cornerRadius = 5.0
            schoolAnnouncementView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var schoolAssignmentView: UIView! {
        didSet {
            schoolAssignmentView.layer.borderColor = UIColor.lightGray.cgColor
            schoolAssignmentView.layer.borderWidth = 1.0
            schoolAssignmentView.layer.cornerRadius = 5.0
            schoolAssignmentView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var schoolTotalDownloadView: UIView! {
        didSet {
            schoolTotalDownloadView.layer.borderColor = UIColor.lightGray.cgColor
            schoolTotalDownloadView.layer.borderWidth = 1.0
            schoolTotalDownloadView.layer.cornerRadius = 5.0
            schoolTotalDownloadView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var schoolTotalView: UIView! {
        didSet {
            schoolTotalView.layer.borderColor = UIColor.lightGray.cgColor
            schoolTotalView.layer.borderWidth = 1.0
            schoolTotalView.layer.cornerRadius = 5.0
            schoolTotalView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var checkOutView: UIView! {
        didSet {
            checkOutView.layer.borderColor = ACColor.MAIN.cgColor
            checkOutView.layer.borderWidth = 1.0
            checkOutView.layer.cornerRadius = checkInView.frame.size.width / 2
            checkOutView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var checkInView: UIView! {
        didSet {
            checkInView.layer.borderColor = ACColor.MAIN.cgColor
            checkInView.layer.borderWidth = 1.0
            checkInView.layer.cornerRadius = checkInView.frame.size.width / 2
            checkInView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var totalParentDownloadView: UIView! {
        didSet {
            totalParentDownloadView.layer.borderColor = UIColor.lightGray.cgColor
            totalParentDownloadView.layer.borderWidth = 1.0
            totalParentDownloadView.layer.cornerRadius = 5.0
            totalParentDownloadView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var totalParentView: UIView! {
        didSet {
            totalParentView.layer.borderColor = UIColor.lightGray.cgColor
            totalParentView.layer.borderWidth = 1.0
            totalParentView.layer.cornerRadius = 5.0
            totalParentView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var totalStudentDownloadView: UIView! {
        didSet {
            totalStudentDownloadView.layer.borderColor = UIColor.lightGray.cgColor
            totalStudentDownloadView.layer.borderWidth = 1.0
            totalStudentDownloadView.layer.cornerRadius = 5.0
            totalStudentDownloadView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var totalStudentView: UIView! {
        didSet {
            totalStudentView.layer.borderColor = UIColor.lightGray.cgColor
            totalStudentView.layer.borderWidth = 1.0
            totalStudentView.layer.cornerRadius = 5.0
            totalStudentView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var middleView: UIView! {
        didSet {
            middleView.layer.borderColor = UIColor.lightGray.cgColor
            middleView.layer.borderWidth = 1.0
            middleView.layer.cornerRadius = 5.0
            middleView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var totalSchoolUserDownloadButton: UIButton!
    @IBOutlet weak var totalSchoolUserDownloadLabel: UILabel!
    @IBOutlet weak var totalSchoolUserButton: UIButton!
    @IBOutlet weak var totalSchoolUserLabel: UILabel!
    @IBOutlet weak var bottomView: UIView! {
        didSet {
            bottomView.layer.borderColor = UIColor.lightGray.cgColor
            bottomView.layer.borderWidth = 1.0
            bottomView.layer.cornerRadius = 5.0
            bottomView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var checkOutLabel: UILabel!
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var totalParentDownloadButton: UIButton!
    @IBOutlet weak var totalParentDownloadLabel: UILabel!
    @IBOutlet weak var totalParentButton: UIButton!
    @IBOutlet weak var totalParentLabel: UILabel!
    @IBOutlet weak var totalStudentDownloadButton: UIButton!
    @IBOutlet weak var totalStudentDownloadLabel: UILabel!
    @IBOutlet weak var totalStudentButton: UIButton!
    @IBOutlet weak var totalStudentLabel: UILabel!
    @IBOutlet weak var schoolDescLabel: UILabel!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolImage: UIImageView!
    @IBOutlet weak var headerInfoView: UIView! {
        didSet {
            headerInfoView.layer.borderColor = ACColor.MAIN.cgColor
            headerInfoView.layer.borderWidth = 1.0
        }
    }
    @IBOutlet weak var schoolPicker: UIButton!
    var detailObj: SchoolMonitoringModel? {
        didSet {
            cellConfig()
        }
    }
    var school_ID = ""
    weak var delegate: SchoolMonitoringHeaderCellDelegate?
    var schoolNames = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
        schoolPicker.addTarget(self, action: #selector(showSchoolPicker), for: .touchUpInside)
        totalStudentButton.addTarget(self, action: #selector(fetchStudentList), for: .touchUpInside)
        totalParentButton.addTarget(self, action: #selector(fetchParentList), for: .touchUpInside)
        totalSchoolUserButton.addTarget(self, action: #selector(fetchSchoolTeacherList), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func fetchStudentList() {
        if school_ID == "" {
            school_ID = ACData.LOGINDATA.dashboardSchoolMenu[0].school_id!
        } else {
            
        }
        ACRequest.POST_SCHOOL_TOTAL_STUDENT(userId: ACData.LOGINDATA.userID, schoolID: school_ID, page: 1, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
            SVProgressHUD.dismiss()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func fetchParentList()  {
        if school_ID == "" {
            school_ID = ACData.LOGINDATA.dashboardSchoolMenu[0].school_id!
        } else {
            
        }
        ACRequest.POST_SCHOOL_TOTAL_PARENT(userId: ACData.LOGINDATA.userID, schoolID: school_ID, page: 1, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
            SVProgressHUD.dismiss()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func fetchSchoolTeacherList() {
        if school_ID == "" {
            school_ID = ACData.LOGINDATA.dashboardSchoolMenu[0].school_id!
        } else {
            
        }
        ACRequest.POST_SCHOOL_TOTAL_TEACHER(userId: ACData.LOGINDATA.userID, schoolID: school_ID, page: 1, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
            SVProgressHUD.dismiss()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func showSchoolPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select School -",
            rows: schoolNames,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.schoolPicker.setTitle(value, for: .normal)
                guard let schoolID = ACData.LOGINDATA.dashboardSchoolMenu[indexes].school_id, let yearID = ACData.LOGINDATA.dashboardSchoolMenu[indexes].year_id else {
                    return
                }
                self.school_ID = schoolID
                self.fetchData(withSchoolID: schoolID, withYearID: yearID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    func fetchData(withSchoolID: String, withYearID: String) {
        ACRequest.POST_SCHOOL_MONITORING(userId: ACData.LOGINDATA.userID, schoolID: withSchoolID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
            ACData.SCHOOLMONITORINGDATA = result
            SVProgressHUD.dismiss()
            self.delegate?.refreshData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        schoolImage.sd_setImage(
            with: URL(string: (obj.school_logo)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        schoolNameLabel.text = obj.school_grade
        schoolDescLabel.text = obj.school_name
        totalStudentLabel.text = "\(obj.student_total_user)"
        totalStudentDownloadLabel.text = "\(obj.student_total_download)"
        totalParentLabel.text = "\(obj.parent_total_user)"
        totalParentDownloadLabel.text = "\(obj.parent_total_download)"
        checkInLabel.text = "\(obj.attendance_clock_in)"
        checkOutLabel.text = "\(obj.attendance_clock_out)"
        totalSchoolUserLabel.text = "\(obj.school_total_user)"
        totalSchoolUserDownloadLabel.text = "\(obj.school_total_download)"
        totalAssignmentLabel.text = "\(obj.total_assignment)"
        pendingAssignmentLabel.text = "\(obj.pending_assignment)"
        totalAnnouncementLabel.text = "\(obj.total_announcement)"
        pendingAnnouncementLabel.text = "\(obj.pending_announcement)"
        totalExamLabel.text = "\(obj.total_exam)"
        pendingExamLabel.text = "\(obj.pending_exam)"
        schoolNames.removeAll()
        for item in ACData.LOGINDATA.dashboardSchoolMenu {
            schoolNames.append(item.school_name!)
        }
    }
}
