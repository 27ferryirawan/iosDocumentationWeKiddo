//
//  AllExamSectionCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 07/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SVProgressHUD

protocol AllExamSectionCellDelegate: class {
    func didSelectTeacher(with value: String)
}

class AllExamSectionCell: UITableViewCell {
    
    @IBOutlet weak var classButton: UIButton!
    @IBOutlet weak var teacherButton: UIButton!
    var classID = ""
    var subjectID = ""
    var teacherID = ""
    var levelName = [String]()
    var teacherName = [String]()
    weak var delegate: AllExamSectionCellDelegate?
    var objTeacher: ExamTeacherListAll? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        classButton.addTarget(self, action: #selector(showClassPicker), for: .touchUpInside)
        teacherButton.addTarget(self, action: #selector(showTeacherPicker), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        teacherName.removeAll()
        guard let obj = objTeacher else { return }
        for item in obj.teacherList {
            teacherName.append(item.teacher_name)
        }
    }
    @objc func showClassPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Subject -",
            rows: levelName,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.classButton.setTitle(value, for: .normal)
                self.classID = ACData.EXAMLISTDATA.exam_subject_list[indexes].subject_id
//                self.fetchUpdateData(withSubjectID: self.subjectID, withClassID: self.classID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showTeacherPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Teacher -",
            rows: teacherName,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.teacherButton.setTitle(value, for: .normal)
                self.teacherID = self.objTeacher?.teacherList[indexes].teacher_id ?? ""
                self.delegate?.didSelectTeacher(with: self.teacherID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
//    func fetchUpdateData(withSubjectID: String, withClassID: String) {
//        print("subject: \(withSubjectID), class: \(withClassID)")
//        if ACData.EXAMLISTDATA != nil {
//            ACData.EXAMLISTDATA.exam_subject_list.removeAll()
//            ACData.EXAMLISTDATA.exam_level_list.removeAll()
//            ACData.EXAMLISTDATA.exam_list.removeAll()
//        }
//        ACRequest.GET_EXAM_LIST(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, levelID: self.subjectID, subjectID: self.classID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
//            SVProgressHUD.dismiss()
//            ACData.EXAMLISTDATA = jsonDatas
//        }) { (message) in
//            SVProgressHUD.dismiss()
//            ACAlert.show(message: message)
//        }
//    }
}
