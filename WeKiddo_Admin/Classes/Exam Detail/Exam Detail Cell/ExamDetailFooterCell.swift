//
//  ExamDetailFooterCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 19/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

protocol ExamDetailFooterCellDelegate: class {
    func toAddScore()
    func toEditExam()
    func closeExam()
}

class ExamDetailFooterCell: UITableViewCell {

    @IBOutlet weak var teacherView: UIView!
    @IBOutlet weak var lbTeacherName: UILabel!
    @IBOutlet weak var ivTeacher: UIImageView!
    
    @IBOutlet weak var closeExamButton: UIButton!
    @IBOutlet weak var editExamButton: UIButton!
    @IBOutlet weak var addScoreButton: UIButton!
    weak var delegate: ExamDetailFooterCellDelegate?
    var detailObj: ExamDetailModel?{
        didSet{
            teacherConfig()
        }
    }
    func teacherConfig(){
        guard let obj = detailObj else { return }
        teacherView.layer.borderColor = UIColor.black.cgColor
        teacherView.layer.borderWidth = 1
        ivTeacher.layer.cornerRadius = ivTeacher.frame.width / 2
        ivTeacher.sd_setImage(with: URL(string: obj.teacher.teacher_image), placeholderImage: nil, options: .refreshCached)
        lbTeacherName.text = obj.teacher.teacher_name
    }
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
        //TODO: Change Value of SchoolID and YearID
        guard let obj = detailObj else { return }
        ACRequest.POST_STUDENT_LIST_SCORE_ADD_NEW(
            userId: ACData.LOGINDATA.userID,
            school_user_id: obj.teacher.teacher_id,
            schoolID: "SCHOOL10",//ACData.LOGINDATA.school_id,
            yearID: "YEAR1",//ACData.LOGINDATA.year_id,
            schoolClassID: obj.school_class_id,
            examID: obj.school_session_exam_id,
            tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (datas) in
            SVProgressHUD.dismiss()
            ACData.EXAMREMEDYSCORELISTDATA = datas
            self.delegate?.toAddScore()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func editExamAction() {
         //TODO: Change Value of SchoolID and YearID
        guard let obj = detailObj else { return }
        ACRequest.POST_GET_DATA_FOR_EDIT_EXAM(
            userId: ACData.LOGINDATA.userID,
            school_user_id: obj.teacher.teacher_id,
            schoolID: "SCHOOL10",//ACData.LOGINDATA.school_id,
            yearID: "YEAR1",//ACData.LOGINDATA.year_id,
            examID: obj.school_session_exam_id,
            schoolClassID: obj.school_class_id,
            tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (datas) in
            SVProgressHUD.dismiss()
            ACData.EXAMEDITDATA = datas
            self.delegate?.toEditExam()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func closeExamAction() {
         //TODO: Change Value of SchoolID and YearID
        guard let obj = detailObj else { return }
        ACRequest.POST_EXAM_CLOSE(
            userId: ACData.LOGINDATA.userID,
            school_user_id: obj.teacher.teacher_id,
            schoolID: "SCHOOL10",//ACData.LOGINDATA.school_id,
            yearID: "YEAR1",//ACData.LOGINDATA.year_id,
            examID: obj.school_session_exam_id,
            tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: status)
                self.delegate?.closeExam()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
