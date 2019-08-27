//
//  ExamDetailRelatedExamCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 19/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class ExamDetailRelatedExamCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 1.0
        }
    }
    var detailObj: ExamDetailRelatedModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        subjectLabel.text = obj.chapter_name
        typeLabel.text = obj.exam_type_name
        dateLabel.text = obj.session_date
    }
}
