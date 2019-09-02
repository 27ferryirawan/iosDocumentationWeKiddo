//
//  EditProfileSubjectCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 16/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

protocol EditProfileSubjectCellDelegate: class {
    func deleteAction()
}

class EditProfileSubjectCell: UITableViewCell {

    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.cornerRadius = 5.0
            bgView.layer.masksToBounds = true
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 0.5
        }
    }
    weak var delegate: EditProfileSubjectCellDelegate?
    var detailObj: AdminAssignSchoolModel? {
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
        ivAvatar.layer.cornerRadius = ivAvatar.frame.width / 2
        ivAvatar.sd_setImage(with: URL(string: obj.school_logo), completed: nil)
        contentLabel.text = "\(obj.school_name)"
    }
}
