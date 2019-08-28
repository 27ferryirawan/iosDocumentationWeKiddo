//
//  HomeRoomUpcomingSessionSectionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class HomeRoomUpcomingSessionSectionCell: UITableViewCell {

    @IBOutlet weak var sectionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func config(isTaskList: Bool, isAbsentCheckList: Bool, isSessionCheckList: Bool) {
        if isTaskList {
            sectionLabel.text = "Task List"
        } else if isAbsentCheckList {
            sectionLabel.text = "Absent Checklist"
        } else {
            sectionLabel.text = "Sessions Checklist"
        }
    }
}
