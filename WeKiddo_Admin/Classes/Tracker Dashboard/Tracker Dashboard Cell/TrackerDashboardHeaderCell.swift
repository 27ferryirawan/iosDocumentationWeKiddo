//
//  TrackerDashboardHeaderCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol TrackerDashboardHeaderCellDelegate: class {
    func toTotalSchoolPage()
}

class TrackerDashboardHeaderCell: UITableViewCell {
    
    @IBOutlet weak var dateView: UIView! {
        didSet {
            dateView.layer.borderWidth = 1.0
            dateView.layer.borderColor = UIColor.lightGray.cgColor
            dateView.layer.cornerRadius = 5.0
            dateView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var totalSchoolView: UIView! {
        didSet {
            totalSchoolView.layer.cornerRadius = 5.0
            totalSchoolView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderWidth = 1.0
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.cornerRadius = 5.0
            bgView.layer.masksToBounds = true
        }
    }
    
    weak var delegate: TrackerDashboardHeaderCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func toTotalSchool(_ sender: UIButton) {
        self.delegate?.toTotalSchoolPage()
    }
    
}
