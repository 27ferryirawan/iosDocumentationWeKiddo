//
//  AddScoreExamFooterCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 24/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AddScoreExamFooterCellDelegate: class {
    func submitAction()
}

class AddScoreExamFooterCell: UITableViewCell {
    @IBOutlet weak var submitButton: UIButton!
    weak var delegate: AddScoreExamFooterCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func submit() {
        self.delegate?.submitAction()
    }
}
