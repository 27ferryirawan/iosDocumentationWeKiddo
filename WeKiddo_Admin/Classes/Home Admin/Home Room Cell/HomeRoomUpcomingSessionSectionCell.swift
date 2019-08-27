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
    func config(isAssignment: Bool, isPermission: Bool, isSpecialAttentionByClass: Bool, isSpecialAttentionBySubject: Bool, isDetention: Bool) {
        if isAssignment {
            sectionLabel.text = "Due Date Assignment"
        } else if isPermission {
            sectionLabel.text = "Permission Request"
        } else if isSpecialAttentionByClass {
            sectionLabel.text = "Special Attention By Class"
        } else if isSpecialAttentionBySubject {
            sectionLabel.text = "Special Attention By Subject"
        } else {
            sectionLabel.text = "Detention"
        }
    }
}
