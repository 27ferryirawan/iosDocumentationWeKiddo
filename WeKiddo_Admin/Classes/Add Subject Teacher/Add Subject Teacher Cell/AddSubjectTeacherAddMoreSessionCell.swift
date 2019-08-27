//
//  AddSubjectTeacherAddMoreSessionCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 14/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AddSubjectTeacherAddMoreSessionCellDelegate: class {
    func addMoreSession()
    func addMoreClass()
}

class AddSubjectTeacherAddMoreSessionCell: UITableViewCell {

    @IBOutlet weak var addMoreButton: UIButton!
    var isAddSession = Bool()
    weak var delegate: AddSubjectTeacherAddMoreSessionCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        addMoreButton.addTarget(self, action: #selector(addMoreSession), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func addMoreSession() {
        if isAddSession {
            self.delegate?.addMoreSession()
        } else {
            self.delegate?.addMoreClass()
        }
    }
}
