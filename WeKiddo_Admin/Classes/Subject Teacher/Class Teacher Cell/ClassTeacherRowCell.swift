//
//  ClassTeacherRowCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 13/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol ClassTeacherRowCellDelegate: class {
    func goToSubjectTeacherListByClass(withSubjectID: String, withSchoolClassID: String)
}

class ClassTeacherRowCell: UITableViewCell {

    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 0.5
        }
    }
    var indexCell = 0
    weak var delegate: ClassTeacherRowCellDelegate?
    var detailObj: SubjectTopicByClassClassShiftModel? {
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
    func cellConfig() {
        guard let obj = detailObj else { return }
        classLabel.text = "\(obj.school_class) - "
        subjectLabel.text = obj.subject_name
    }
    @IBAction func goToDetail(_ sender: Any) {
        guard let obj = detailObj else { return }
        ACRequest.POST_SEE_SUBJECT_TEACHER_SESSION_LIST(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, schoolClassID: obj.school_class_id, subjectID: obj.subject_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            SVProgressHUD.dismiss()
            ACData.SUBJECTTEACHERBYCLASSSESSIONLISTDATA = jsonDatas
            self.delegate?.goToSubjectTeacherListByClass(withSubjectID: obj.subject_id, withSchoolClassID: obj.school_class_id)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
