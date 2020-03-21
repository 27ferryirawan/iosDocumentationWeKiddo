//
//  StudentDashboardContentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

class StudentDashboardContentCell: UITableViewCell {

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
