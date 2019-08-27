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
}

class AssignmentSectionCell: UITableViewCell {

    @IBOutlet weak var classButton: UIButton!
    @IBOutlet weak var subjectButton: UIButton!
    var classID = ""
    var subjectID = ""
    var className = [String]()
    var subjectName = [String]()
    weak var delegate: AssignmentSectionCellDelegate?
    var object: AssignmentListModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        classButton.addTarget(self, action: #selector(showClassPicker), for: .touchUpInside)
        subjectButton.addTarget(self, action: #selector(showSubjectPicker), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = object else { return }
        for item in obj.assignmentPickerSubject {
            subjectName.append(item.subject_name)
        }
        for item in obj.assignmentPickerClass {
            className.append(item.school_class)
        }
    }
    @objc func showClassPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Class -",
            rows: className,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.classButton.setTitle(value, for: .normal)
                self.classID = ACData.ASSIGNMENTLIST.assignmentPickerClass[indexes].school_class_id
                self.fetchUpdateData(withSubjectID: self.subjectID, withClassID: self.classID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showSubjectPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Subject -",
            rows: subjectName,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.subjectButton.setTitle(value, for: .normal)
                self.subjectID = ACData.ASSIGNMENTLIST.assignmentPickerSubject[indexes].subject_id
                self.fetchUpdateData(withSubjectID: self.subjectID, withClassID: self.classID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    func fetchUpdateData(withSubjectID: String, withClassID: String) {
        print("subject: \(withSubjectID), class: \(withClassID)")
        if ACData.EXAMLISTDATA != nil {
            ACData.EXAMLISTDATA.exam_subject_list.removeAll()
            ACData.EXAMLISTDATA.exam_level_list.removeAll()
            ACData.EXAMLISTDATA.exam_list.removeAll()
        }
        subjectName.removeAll()
        className.removeAll()
        ACRequest.POST_ASSIGNMENT_LIST(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, subjectID: self.subjectID, classID: self.classID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (assignmentDatas) in
            ACData.ASSIGNMENTLIST = assignmentDatas
            SVProgressHUD.dismiss()
            self.delegate?.reloadTable()
        }) { (message) in
            SVProgressHUD.dismiss()
        }

    }
}
