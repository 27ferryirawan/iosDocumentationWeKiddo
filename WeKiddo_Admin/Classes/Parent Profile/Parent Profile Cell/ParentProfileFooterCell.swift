//
//  ParentProfileFooterCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 15/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol ParentProfileFooterCellDelegate: class {
    func changPass()
    func editProf()
}

class ParentProfileFooterCell: UITableViewCell {

    @IBOutlet weak var changePasswordBtn: UIButton! {
        didSet {
            changePasswordBtn.layer.cornerRadius = 5
            changePasswordBtn.clipsToBounds = true
        }
    }
    @IBOutlet weak var changeProfileBtn: UIButton! {
        didSet {
            changeProfileBtn.layer.cornerRadius = 5
            changeProfileBtn.clipsToBounds = true
        }
    }
    weak var delegate: ParentProfileFooterCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        changePasswordBtn.addTarget(self, action: #selector(changePassAction), for: .touchUpInside)
        changeProfileBtn.addTarget(self, action: #selector(editProfAction), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func changePassAction() {
        self.delegate?.changPass()
    }
    @objc func editProfAction() {
        self.delegate?.editProf()
    }
}
