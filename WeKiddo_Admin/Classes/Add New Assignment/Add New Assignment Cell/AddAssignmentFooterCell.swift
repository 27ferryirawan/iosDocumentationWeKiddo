//
//  AddAssignmentFooterCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 05/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AddAssignmentFooterCellDelegate: class {
    func addMoreClass(counter: Int)
    func saveAssignment()
}

class AddAssignmentFooterCell: UITableViewCell {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addClassButton: UIButton!
    weak var delegate: AddAssignmentFooterCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        addClassButton.addTarget(self, action: #selector(addClassAction), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func saveAction() {
        self.delegate?.saveAssignment()
    }
    @objc func addClassAction() {
        self.delegate?.addMoreClass(counter: 1)
    }
}
