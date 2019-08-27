//
//  PermissionRequestAttachmentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 01/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol PermissionRequestAttachmentCellDelegate: class {
    func displayAttachment(withUrl: String)
}

class PermissionRequestAttachmentCell: UITableViewCell {

    weak var delegate: PermissionRequestAttachmentCellDelegate?
    @IBOutlet weak var attachmentButton: UIButton!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.gray, shadowRadius: 1.0, shadowOpactiy: 0.5, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    @IBOutlet weak var attachmentName: UILabel!
    var mediaObj: PermissionMediaModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        attachmentButton.addTarget(self, action: #selector(viewAttachment), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = mediaObj else { return }
        attachmentName.text = obj.mediaId
    }
    @objc func viewAttachment() {
        guard let obj = mediaObj else { return }
        self.delegate?.displayAttachment(withUrl: obj.mediaURL)
    }
}
