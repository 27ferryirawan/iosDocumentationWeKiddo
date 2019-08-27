//
//  EditExamRemediScheduleCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 25/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

protocol EditExamRemediScheduleCellDelegate: class {
    func showEditRemediView(withIndex: Int)
}

class EditExamRemediScheduleCell: UITableViewCell {

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var remediLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 1.0
        }
    }
    var index = 0
    weak var delegate: EditExamRemediScheduleCellDelegate?
    var detailObj: ExamEditExamRemedyModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        editButton.addTarget(self, action: #selector(editRemedi), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        remediLabel.text = "\(index+1). \(obj.title)"
        dateLabel.text = obj.remedy_date
    }
    @objc func editRemedi() {
        self.delegate?.showEditRemediView(withIndex: index)
    }
}
