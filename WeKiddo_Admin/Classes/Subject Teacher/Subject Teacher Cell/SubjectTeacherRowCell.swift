//
//  SubjectTeacherRowCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 13/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol SubjectTeacherRowCellDelegate: class {
    func goToSubjectTeacherList()
}

class SubjectTeacherRowCell: UITableViewCell {

    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 0.5
        }
    }
    weak var delegate: SubjectTeacherRowCellDelegate?
    var indexCell = 0
    var detailObj: SubjectTopicBySubjectClassShiftModel? {
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
    @IBAction func goToDetail(_ sender: Any) {
        guard let obj = detailObj else { return }
        ACRequest.POST_SEE_SUBJECT_TEACHER_CHAPTER_LIST(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, schoolLevelID: obj.school_level_id, subjectID: ACData.SUBJECTTEACHERBYSUBJECT[indexCell].subject_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            ACData.SUBJECTTEACHERCHAPTERLISTDATA = jsonDatas
            SVProgressHUD.dismiss()
            self.delegate?.goToSubjectTeacherList()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        classLabel.text = obj.school_level
    }
}
