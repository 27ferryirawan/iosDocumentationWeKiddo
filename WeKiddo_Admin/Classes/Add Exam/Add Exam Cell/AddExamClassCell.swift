//
//  AddExamClassCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 25/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol AddExamClassCellDelegate: class {
    func classSelectedWithValue(value: String, atIndex: Int)
}

class AddExamClassCell: UITableViewCell {

    @IBOutlet weak var examClassButton: UIButton!
    weak var delegate: AddExamClassCellDelegate?
    var classArray = [String]()
    var indexCell = 0
    var detailObj: ExamMajorModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        examClassButton.addTarget(self, action: #selector(showClassPicker), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        classArray.removeAll()
        guard let obj = detailObj else { return }
        for item in obj.exam_class {
            classArray.append(item.school_class)
        }
    }
    @objc func showClassPicker() {
        guard let obj = detailObj else { return }
        ActionSheetStringPicker.show(
            withTitle: "- Select Class -",
            rows: classArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.examClassButton.setTitle(value, for: .normal)
                let examClassID = obj.exam_class[indexes].school_class_id
                self.delegate?.classSelectedWithValue(value: examClassID, atIndex: self.indexCell)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
}
