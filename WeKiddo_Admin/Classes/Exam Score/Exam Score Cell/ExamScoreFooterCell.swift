//
//  ExamScoreFooterCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 24/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol ExamScoreFooterCellDelegate: class {
    func refreshTable()
}

class ExamScoreFooterCell: UITableViewCell {

    @IBOutlet weak var submitScoreButton: UIButton!
    weak var delegate: ExamScoreFooterCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        submitScoreButton.addTarget(self, action: #selector(submitScoreAction), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func submitScoreAction() {
        self.delegate?.refreshTable()
    }
}
