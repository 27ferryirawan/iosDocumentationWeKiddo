//
//  ExamDetailFooterCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 19/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol ExamDetailFooterCellDelegate: class {
    func toAddScore()
    func toEditExam()
    func closeExam()
}

class ExamDetailFooterCell: UITableViewCell {

    @IBOutlet weak var closeExamButton: UIButton!
    @IBOutlet weak var editExamButton: UIButton!
    @IBOutlet weak var addScoreButton: UIButton!
    weak var delegate: ExamDetailFooterCellDelegate?
    var detailObj: ExamDetailModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        addScoreButton.addTarget(self, action: #selector(addScoreAction), for: .touchUpInside)
        editExamButton.addTarget(self, action: #selector(editExamAction), for: .touchUpInside)
        closeExamButton.addTarget(self, action: #selector(closeExamAction), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func addScoreAction() {
        guard let obj = detailObj else { return }
        ACRequest.POST_STUDENT_LIST_SCORE_ADD_NEW(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, schoolClassID: obj.school_class_id, examID: obj.school_session_exam_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (datas) in
            SVProgressHUD.dismiss()
            ACData.EXAMREMEDYSCORELISTDATA = datas
            self.delegate?.toAddScore()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func editExamAction() {
        guard let obj = detailObj else { return }
        ACRequest.POST_GET_DATA_FOR_EDIT_EXAM(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, examID: obj.school_session_exam_id, schoolClassID: obj.school_class_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (datas) in
            SVProgressHUD.dismiss()
            ACData.EXAMEDITDATA = datas
            self.delegate?.toEditExam()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func closeExamAction() {
        guard let obj = detailObj else { return }
        ACRequest.POST_EXAM_CLOSE(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role
            , schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, examID: obj.school_session_exam_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: status)
                self.delegate?.closeExam()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
