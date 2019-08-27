//
//  SearchSectionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 12/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SearchSectionCell: UITableViewCell {

    @IBOutlet weak var sectionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func config(isAssignment: Bool) {
        if isAssignment {
            sectionLabel.text = "Upcoming Assignment"
        } else {
            sectionLabel.text = "Upcoming Session"
        }
    }
}
