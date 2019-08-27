//
//  EditExamSectionCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 25/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol EditExamSectionCellDelegate: class {
    func showAddRemediView()
}

class EditExamSectionCell: UITableViewCell {
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var sectionIcon: UIImageView!
    @IBOutlet weak var sectionAddLabel: UILabel!
    @IBOutlet weak var buttonSection: UIButton!
    weak var delegate: EditExamSectionCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonSection.addTarget(self, action: #selector(addRemedi), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func addRemedi() {
        self.delegate?.showAddRemediView()
    }
    func config(isRelated: Bool) {
        if isRelated {
            buttonSection.isUserInteractionEnabled = false
            sectionIcon.isHidden = true
            sectionAddLabel.isHidden = true
            sectionLabel.text = "Related Exams"
        } else {
            buttonSection.isUserInteractionEnabled = true
            sectionIcon.isHidden = false
            sectionAddLabel.isHidden = false
            sectionLabel.text = "Remedi Schedule"
        }
    }
}
