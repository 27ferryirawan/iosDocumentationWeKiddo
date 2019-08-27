//
//  AssignmentScoreFooterCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 06/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol AssignmentScoreFooterCellDelegate: class {
    func submitAction()
}

class AssignmentScoreFooterCell: UITableViewCell {

    @IBOutlet weak var submitButton: UIButton!
    weak var delegate: AssignmentScoreFooterCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        submitButton.addTarget(self, action: #selector(submitScore), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func submitScore(){
        self.delegate?.submitAction()
    }
}
