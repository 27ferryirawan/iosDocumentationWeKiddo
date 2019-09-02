//
//  AddNewTaskAdminSubmitButtonCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 02/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AddNewTaskAdminSubmitButtonCellDelegate: class {
    func saveAction()
}

class AddNewTaskAdminSubmitButtonCell: UITableViewCell {

    @IBOutlet weak var saveButton: UIButton!
    weak var delegate: AddNewTaskAdminSubmitButtonCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        saveButton.addTarget(self, action: #selector(saveProcess), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func saveProcess() {
        self.delegate?.saveAction()
    }
}
