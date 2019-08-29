//
//  NotificationSectionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 17/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SVProgressHUD

protocol AssignmentSectionCellDelegate: class {
    func reloadTable()
    func filterTeacher(with teacherID: String)
}

class AssignmentSectionCell: UITableViewCell {

    @IBOutlet weak var classButton: UIButton!
    @IBOutlet weak var subjectButton: UIButton!
    var teacherID = ""
    var teacherName = [String]()
    weak var delegate: AssignmentSectionCellDelegate?
    var object: AssignmentTeacherListAllModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        classButton.addTarget(self, action: #selector(showClassPicker), for: .touchUpInside)
        subjectButton.addTarget(self, action: #selector(showSubjectPicker), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = object else { return }
        for item in obj.assignmentTeacherList {
            teacherName.append(item.teacher_name)
        }
    }

    @objc func showSubjectPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Subject -",
            rows: teacherName,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.subjectButton.setTitle(value, for: .normal)
                self.teacherID = ACData.ASSIGNMENTTEACHERLISTALL.assignmentTeacherList[indexes].teacher_id
                self.delegate?.filterTeacher(with: self.teacherID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
}
