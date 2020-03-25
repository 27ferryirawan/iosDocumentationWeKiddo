//
//  TrackerUserCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol TrackerUserCellDelegate: class {
    func toDetailDashboard(withIndex: Int)
}

class TrackerUserCell: UITableViewCell {
    
    @IBOutlet weak var totalActiveLabel: UILabel!
    @IBOutlet weak var totalActivePercentLabel: UILabel!
    
    @IBOutlet weak var totalLoginLabel: UILabel!
    @IBOutlet weak var totalLoginPercentLabel: UILabel!
    
    @IBOutlet weak var totalDownloadLabel: UILabel!
    @IBOutlet weak var totalDownloadPercentLabel: UILabel!
    
    @IBOutlet weak var titleUserLabel: UILabel!
    @IBOutlet weak var totalUserLabel: UILabel!
    @IBOutlet weak var imageLeft: UIImageView!
    
    @IBOutlet weak var sectionLabel: UILabel!
    
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var totalActiveView: UIView! {
        didSet {
            totalActiveView.layer.cornerRadius = 5.0
            totalActiveView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var totalLoginView: UIView! {
        didSet {
            totalLoginView.layer.cornerRadius = 5.0
            totalLoginView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var totalDownloadView: UIView! {
        didSet {
            totalDownloadView.layer.cornerRadius = 5.0
            totalDownloadView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var totalUserView: UIView! {
        didSet {
            totalUserView.layer.cornerRadius = 5.0
            totalUserView.layer.masksToBounds = true
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
    
    weak var delegate: TrackerUserCellDelegate?
    var index = 0
    
    var detailObj: DashboardCoordinatorModel? {
        didSet {
            cellConfig()
        }
    }
    
    var detailSchoolObj: DashboardDetailSchoolModel? {
        didSet {
            cellConfigSchool()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailButton.addTarget(self, action: #selector(toDetailAction), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func toDetailAction() {
        self.delegate?.toDetailDashboard(withIndex: index)
    }
    
    func cellConfigSchool() {
        guard let obj = detailSchoolObj else { return }
        if index == 4 {
            sectionLabel.text = "Student"
//            imageLeft.image = UIImage(named: "")
            totalUserLabel.text = "\(obj.student_total_student)"
            titleUserLabel.text = "Total Student"
            
            totalDownloadPercentLabel.text = "\(obj.student_percentage_download)%"
            totalDownloadLabel.text = "\(obj.student_total_download)"
            
            totalLoginPercentLabel.text = "\(obj.student_percentage_login)%"
            totalLoginLabel.text = "\(obj.student_total_login)"
            
            totalActivePercentLabel.text = "\(obj.student_percentage_active)%"
            totalActiveLabel.text = "\(obj.student_total_active)"
        } else if index == 5 {
            sectionLabel.text = "Teacher"
//            imageLeft.image = UIImage(named: "")
            totalUserLabel.text = "\(obj.teacher_total_teacher)"
            titleUserLabel.text = "Total Teacher"
            
            totalDownloadPercentLabel.text = "\(obj.teacher_percentage_download)%"
            totalDownloadLabel.text = "\(obj.teacher_total_download)"
            
            totalLoginPercentLabel.text = "\(obj.teacher_percentage_login)%"
            totalLoginLabel.text = "\(obj.teacher_total_login)"
            
            totalActivePercentLabel.text = "\(obj.teacher_percentage_active)%"
            totalActiveLabel.text = "\(obj.teacher_total_active)"
        } else {
            sectionLabel.text = "Parent"
//            imageLeft.image = UIImage(named: "")
            totalUserLabel.text = "\(obj.parent_total_parent)"
            titleUserLabel.text = "Total Parent"
            
            totalDownloadPercentLabel.text = "\(obj.parent_percentage_download)%"
            totalDownloadLabel.text = "\(obj.parent_total_download)"
            
            totalLoginPercentLabel.text = "\(obj.parent_percentage_login)%"
            totalLoginLabel.text = "\(obj.parent_total_login)"
            
            totalActivePercentLabel.text = "\(obj.parent_percentage_active)%"
            totalActiveLabel.text = "\(obj.parent_total_active)"
        }
    }
    
    func cellConfig() {
        guard let obj = detailObj else { return }
        if index == 4 {
            sectionLabel.text = "Student"
//            imageLeft.image = UIImage(named: "")
            totalUserLabel.text = "\(obj.student_total_user)"
            titleUserLabel.text = "Total Student"
            
            totalDownloadPercentLabel.text = "\(obj.student_total_download_percent)%"
            totalDownloadLabel.text = "\(obj.student_total_download)"
            
            totalLoginPercentLabel.text = "\(obj.student_total_login_percent)%"
            totalLoginLabel.text = "\(obj.student_total_login)"
            
            totalActivePercentLabel.text = "\(obj.student_total_active_percent)%"
            totalActiveLabel.text = "\(obj.student_total_active)"
        } else if index == 5 {
            sectionLabel.text = "Teacher"
//            imageLeft.image = UIImage(named: "")
            totalUserLabel.text = "\(obj.teacher_total_user)"
            titleUserLabel.text = "Total Teacher"
            
            totalDownloadPercentLabel.text = "\(obj.teacher_total_download_percent)%"
            totalDownloadLabel.text = "\(obj.teacher_total_download)"
            
            totalLoginPercentLabel.text = "\(obj.teacher_total_login_percent)%"
            totalLoginLabel.text = "\(obj.teacher_total_login)"
            
            totalActivePercentLabel.text = "\(obj.teacher_total_active_percent)%"
            totalActiveLabel.text = "\(obj.teacher_total_active)"
        } else {
            sectionLabel.text = "Parent"
//            imageLeft.image = UIImage(named: "")
            totalUserLabel.text = "\(obj.parent_total_user)"
            titleUserLabel.text = "Total Parent"
            
            totalDownloadPercentLabel.text = "\(obj.parent_total_download_percent)%"
            totalDownloadLabel.text = "\(obj.parent_total_download)"
            
            totalLoginPercentLabel.text = "\(obj.parent_total_login_percent)%"
            totalLoginLabel.text = "\(obj.parent_total_login)"
            
            totalActivePercentLabel.text = "\(obj.parent_total_active_percent)%"
            totalActiveLabel.text = "\(obj.parent_total_active)"
        }
    }
}
