//
//  StudentDashboardContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage

class StudentDashboardContentCell: UITableViewCell {
    
    @IBOutlet weak var labelLeft: UILabel!
    @IBOutlet weak var totalActivePercentLabel: UILabel!
    @IBOutlet weak var totalActiveLabel: UILabel!
    
    @IBOutlet weak var totalLoginPercentLabel: UILabel!
    @IBOutlet weak var totalLoginLabel: UILabel!
    
    @IBOutlet weak var totalDownloadPercentLabel: UILabel!
    @IBOutlet weak var totalDownloadLabel: UILabel!
    
    @IBOutlet weak var totalStudentLabel: UILabel!
    
    @IBOutlet weak var weeklyLoginLabel: UILabel!
    @IBOutlet weak var weeklyActiveLabel: UILabel!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var schoolImage: UIImageView!
    @IBOutlet weak var statusView: UIView!
    
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
    
    var detailObj: DashboardCoordinatorStudentListModel? {
        didSet {
            cellConfig()
        }
    }
    
    var detailTeacherObj: DashboardCoordinatorTeacherListModel? {
        didSet {
            cellTeacherConfig()
        }
    }
    
    var detailParentObj: DashboardCoordinatorParentListModel? {
        didSet {
            cellParentConfig()
        }
    }
    
    var isStudent = Bool()
    var isTeacher = Bool()
    var isParent = Bool()
    
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
        self.schoolImage.sd_setImage(
            with: URL(string: (obj.school_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        schoolName.text = obj.school_name
        labelLeft.text = "Total Student"
        weeklyLoginLabel.text = "Login : \(obj.weekly_statistic_login)%"
        weeklyActiveLabel.text = "Active : \(obj.weekly_statistic_active)%"
        
        totalStudentLabel.text = "\(obj.total_student)"
        
        totalDownloadLabel.text = "\(obj.total_download)"
        totalDownloadPercentLabel.text = "\(obj.total_download_percent)%"
        
        totalLoginLabel.text = "\(obj.total_login)"
        totalLoginPercentLabel.text = "\(obj.total_login_percent)%"
        
        totalActiveLabel.text = "\(obj.total_active)"
        totalActivePercentLabel.text = "\(obj.total_active_percent)%"
        /*
        if obj.status == 1 {
            statusView.backgroundColor = .green
        } else if obj.status == 2 {
            statusView.backgroundColor = .orange
        } else {
            statusView.backgroundColor = .blue
        }
        */
    }
    
    func cellTeacherConfig() {
        guard let obj = detailTeacherObj else { return }
        self.schoolImage.sd_setImage(
            with: URL(string: (obj.school_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        schoolName.text = obj.school_name
        labelLeft.text = "Total Teacher"
        weeklyLoginLabel.text = "Login : \(obj.weekly_statistic_login)%"
        weeklyActiveLabel.text = "Active : \(obj.weekly_statistic_active)%"
        
        totalStudentLabel.text = "\(obj.total_teacher)"
        
        totalDownloadLabel.text = "\(obj.total_download)"
        totalDownloadPercentLabel.text = "\(obj.total_download_percent)%"
        
        totalLoginLabel.text = "\(obj.total_login)"
        totalLoginPercentLabel.text = "\(obj.total_login_percent)%"
        
        totalActiveLabel.text = "\(obj.total_active)"
        totalActivePercentLabel.text = "\(obj.total_active_percent)%"
        /*
        if obj.status == 1 {
            statusView.backgroundColor = .green
        } else if obj.status == 2 {
            statusView.backgroundColor = .orange
        } else {
            statusView.backgroundColor = .blue
        }
        */
    }
    
    func cellParentConfig() {
        guard let obj = detailParentObj else { return }
        self.schoolImage.sd_setImage(
            with: URL(string: (obj.school_image)),
            placeholderImage: UIImage(named: "WeKiddoLogo"),
            options: .refreshCached
        )
        schoolName.text = obj.school_name
        labelLeft.text = "Total Parent"
        weeklyLoginLabel.text = "Login : \(obj.weekly_statistic_login)%"
        weeklyActiveLabel.text = "Active : \(obj.weekly_statistic_active)%"
        
        totalStudentLabel.text = "\(obj.total_parent)"
        
        totalDownloadLabel.text = "\(obj.total_download)"
        totalDownloadPercentLabel.text = "\(obj.total_download_percent)%"
        
        totalLoginLabel.text = "\(obj.total_login)"
        totalLoginPercentLabel.text = "\(obj.total_login_percent)%"
        
        totalActiveLabel.text = "\(obj.total_active)"
        totalActivePercentLabel.text = "\(obj.total_active_percent)%"
        /*
        if obj.status == 1 {
            statusView.backgroundColor = .green
        } else if obj.status == 2 {
            statusView.backgroundColor = .orange
        } else {
            statusView.backgroundColor = .blue
        }
        */
    }
}
