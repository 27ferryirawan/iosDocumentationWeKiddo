//
//  AddSubjectTeacherSectionCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 14/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol AddSubjectTeacherSectionCellDelegate: class {
    func classSelected(withClassName: String, withClassID: String, withCurrentID: Int, withIndexpathat: Int)
}

class AddSubjectTeacherSectionCell: UITableViewCell {

    @IBOutlet weak var classPickerButton: UIButton!
    var detailObj: SubjectTeacherParamModel? {
        didSet {
            cellConfig()
        }
    }
    var currentIndex = 0
    var indexPathat = 0
    weak var delegate: AddSubjectTeacherSectionCellDelegate?
    var classArray = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
        print("current index from cell: \(currentIndex)")
        classPickerButton.addTarget(self, action: #selector(showClassPicker), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        classArray.removeAll()
        for item in obj.class_param {
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
                self.classPickerButton.setTitle(value, for: .normal)
                let class_id = obj.class_param[indexes].school_class_id
                self.delegate?.classSelected(withClassName: value, withClassID: class_id, withCurrentID: self.currentIndex, withIndexpathat: self.indexPathat)
            },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
}
