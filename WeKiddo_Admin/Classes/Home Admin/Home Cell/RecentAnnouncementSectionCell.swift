//
//  AnnouncementSectionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class RecentAnnouncementSectionCell: UITableViewCell {

    @IBOutlet weak var sectionLabel: UILabel!
    var isExam = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if isExam {
            sectionLabel.text = "Exam Schedule(s)"
        } else {
            sectionLabel.text = "Recent Announcement(s)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
