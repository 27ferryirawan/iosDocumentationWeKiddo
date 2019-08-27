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
    func reloadTable()
}

class AllExamSectionCell: UITableViewCell {
    
    @IBOutlet weak var classButton: UIButton!
    @IBOutlet weak var subjectButton: UIButton!
    var classID = ""
    var subjectID = ""
    var levelName = [String]()
    var subjectName = [String]()
    weak var delegate: AllExamSectionCellDelegate?
    var objectSubject: ExamListDataModel? {
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
        subjectName.removeAll()
        levelName.removeAll()
        guard let obj = objectSubject else { return }
        for item in obj.exam_subject_list {
            subjectName.append(item.subject_name)
        }
        for item in obj.exam_level_list {
            levelName.append(item.school_level)
        }
    }
    @objc func showClassPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Subject -",
            rows: subjectName,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.classButton.setTitle(value, for: .normal)
                self.classID = ACData.EXAMLISTDATA.exam_subject_list[indexes].subject_id
                self.fetchUpdateData(withSubjectID: self.subjectID, withClassID: self.classID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showSubjectPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Level -",
            rows: levelName,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.subjectButton.setTitle(value, for: .normal)
                self.subjectID = ACData.EXAMLISTDATA.exam_level_list[indexes].school_level_id
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
        ACRequest.GET_EXAM_LIST(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, levelID: self.subjectID, subjectID: self.classID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            SVProgressHUD.dismiss()
            ACData.EXAMLISTDATA = jsonDatas
            self.delegate?.reloadTable()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
