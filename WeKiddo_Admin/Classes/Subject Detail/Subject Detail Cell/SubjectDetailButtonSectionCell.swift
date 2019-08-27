//
//  SubjectDetailButtonSectionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 11/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SubjectDetailButtonSectionCell: UITableViewCell {

    @IBOutlet weak var buttonSection: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func config(isAssignment: Bool) {
        if isAssignment {
            buttonSection.setTitle("SEE MORE ASSIGNMENT(s)", for: .normal)
        } else {
            buttonSection.setTitle("SEE MORE SESSION(s)", for: .normal)
        }
    }
}
