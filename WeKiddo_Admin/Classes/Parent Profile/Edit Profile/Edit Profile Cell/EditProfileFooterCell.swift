//
//  EditProfileFooterCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 16/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol EditProfileFooterCellDelegate: class {
    func didTapSave()
}

class EditProfileFooterCell: UITableViewCell {

    @IBOutlet weak var saveButton: UIButton!
    weak var delegate: EditProfileFooterCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        saveButton.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func saveProfile() {
        self.delegate?.didTapSave()
    }
}
