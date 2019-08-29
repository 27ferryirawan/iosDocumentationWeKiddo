//
//  SchoolMonitoringHeaderCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 29/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SchoolMonitoringHeaderCell: UITableViewCell {
    
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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
