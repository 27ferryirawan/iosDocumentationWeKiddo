//
//  AddSubjectTeacherSectionAttachmentCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 15/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AddSubjectTeacherSectionAttachmentCell: UITableViewCell {

    @IBOutlet weak var sectionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig(isAttachment: Bool) {
        if isAttachment {
            sectionLabel.text = "Attachment"
        } else {
            sectionLabel.text = "Voice Notes"
        }
    }
}
