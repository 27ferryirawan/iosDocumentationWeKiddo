//
//  SubjectDetailSectionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 11/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SubjectDetailSectionCell: UITableViewCell {

    @IBOutlet weak var sectionTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func config(isAssignment: Bool) {
        if isAssignment {
            sectionTitleLabel.text = "Upcoming Assignment(s)"
        } else {
            sectionTitleLabel.text = "Upcoming Session(s)"
        }
    }
}
