//
//  SubjectTeacherDetailExamCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 13/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol SubjectTeacherDetailExamCellDelegate: class {
    func editSubjectTeacher()
}

class SubjectTeacherDetailExamCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var typeExamLabel: UILabel!
    @IBOutlet weak var setAsExamLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.gray, shadowRadius: 1.0, shadowOpactiy: 1, shadowOffsetWidth: Int(0.5), shadowOffsetHeight: 1)
        }
    }
    var detailObj: SubjectTeacherDetailModel? {
        didSet {
            cellConfig()
        }
    }
    weak var delegate: SubjectTeacherDetailExamCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        editButton.addTarget(self, action: #selector(editSubjectAction), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        if obj.is_exam {
            setAsExamLabel.text = "Set As Exam : \(obj.is_exam)"
            typeExamLabel.text = "Type : \(obj.exam_type_name)"
            descLabel.text = obj.exam_desc
        } else {
            setAsExamLabel.text = "Set As Exam : \(obj.is_exam)"
            typeExamLabel.text = "Type : -"
            descLabel.text = "-"
        }
    }
    @objc func editSubjectAction() {
        guard let obj = detailObj else { return }
        ACRequest.POST_SUBJECT_TEACHER_CHAPTER_DETAIL_EDIT(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, schoolLevelID: ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_level_id, subjectID: ACData.SUBJECTTEACHERCHAPTERLISTDATA.subject_id, chapterID: obj.chapter_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (detailData) in
            SVProgressHUD.dismiss()
            ACData.SUBJECTTEACHERDETAILMODEL = detailData
            self.delegate?.editSubjectTeacher()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
