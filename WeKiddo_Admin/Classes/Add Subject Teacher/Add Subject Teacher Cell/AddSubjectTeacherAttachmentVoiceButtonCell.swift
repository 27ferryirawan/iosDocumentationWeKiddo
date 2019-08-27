//
//  AddSubjectTeacherAttachmentVoiceButtonCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 14/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AddSubjectTeacherAttachmentVoiceButtonCellDelegate: class {
    func showAttachmentView(isAttachment: Bool)
}

class AddSubjectTeacherAttachmentVoiceButtonCell: UITableViewCell {

    @IBOutlet weak var voiceNoteButton: UIButton!
    @IBOutlet weak var attachmentButton: UIButton!
    weak var delegate: AddSubjectTeacherAttachmentVoiceButtonCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        attachmentButton.addTarget(self, action: #selector(showAttachment), for: .touchUpInside)
        voiceNoteButton.addTarget(self, action: #selector(showVoiceNote), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func showAttachment() {
        self.delegate?.showAttachmentView(isAttachment: true)
    }
    @objc func showVoiceNote() {
        self.delegate?.showAttachmentView(isAttachment: false)
    }
}
