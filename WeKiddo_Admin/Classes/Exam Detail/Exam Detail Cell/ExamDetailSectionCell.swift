//
//  ExamDetailSectionCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 19/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class ExamDetailSectionCell: UITableViewCell {

    @IBOutlet weak var sectionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig(isRemedi: Bool) {
        if isRemedi {
            sectionLabel.text = "Remedi Schedule"
        } else {
            sectionLabel.text = "Related Exams"
        }
    }
}
