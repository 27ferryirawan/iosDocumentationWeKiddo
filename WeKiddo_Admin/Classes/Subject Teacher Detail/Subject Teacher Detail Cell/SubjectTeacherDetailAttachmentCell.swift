//
//  SubjectTeacherDetailAttachmentCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 13/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SubjectTeacherDetailAttachmentCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: .lightGray, shadowRadius: 1.0, shadowOpactiy: 1.0, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    @IBOutlet weak var attachmentNameLabel: UILabel!
    var detailObj: SubjectTeacherDetailMediasModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        if obj.media_type_id != "MT6" {
            attachmentNameLabel.text = "Attachment"
        } else {
            attachmentNameLabel.text = "Voice Note"
        }
    }
}
