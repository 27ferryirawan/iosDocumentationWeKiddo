//
//  AddSubjectTeacherAttachmentCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 14/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AddSubjectTeacherAttachmentCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    var detailAttcObj: SubjectTeacherAttachmentArrayModel? {
        didSet {
            cellConfig()
        }
    }
    var detailVNObj: SubjectTeacherVoiceNotesArrayModel? {
        didSet {
            cellSet()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func cellConfig() {
        guard let obj = detailAttcObj else { return }
        contentLabel.text = obj.attach_title
    }
    @objc func cellSet() {
        guard let obj = detailVNObj else { return }
        contentLabel.text = obj.attach_title
    }
}
