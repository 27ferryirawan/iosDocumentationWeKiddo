//
//  EditProfileSubjectCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 16/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol EditProfileSubjectCellDelegate: class {
    func deleteAction()
}

class EditProfileSubjectCell: UITableViewCell {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.cornerRadius = 5.0
            bgView.layer.masksToBounds = true
            bgView.layer.borderColor = UIColor.lightGray.cgColor
            bgView.layer.borderWidth = 0.5
        }
    }
    weak var delegate: EditProfileSubjectCellDelegate?
    var detailObj: ProfileSubjectClassModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        deleteButton.addTarget(self, action: #selector(deleteSubject), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        contentLabel.text = "\(obj.subject_name) - \(obj.school_class)"
    }
    @objc func deleteSubject() {
        guard let obj = detailObj else { return }
        ACRequest.POST_DELETE_SUBJECT_EDIT_PROFILE(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, schoolSubjectTeacherID: obj.school_subject_teacher_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            self.delegate?.deleteAction()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
