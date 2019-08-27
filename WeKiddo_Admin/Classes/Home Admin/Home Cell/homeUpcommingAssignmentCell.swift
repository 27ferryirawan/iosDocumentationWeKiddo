//
//  homeUpcommingAssignmentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class homeUpcommingAssignmentCell: UITableViewCell {

    @IBOutlet weak var sectionLabel: UILabel!
    var isExam = Bool() {
        didSet {
            if isExam {
                sectionLabel.text = "Exam Schedule(s)"
            } else {
                sectionLabel.text = "Upcomming Assignment(s)"
            }
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
