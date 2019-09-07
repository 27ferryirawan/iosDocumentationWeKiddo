//
//  AddUserSubjectClassCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 06/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AddUserSubjectClassCellDelegate: class {
    func refreshData()
}

class AddUserSubjectClassCell: UITableViewCell {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var classLabel: UILabel!
    var schoolID = ""
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.groupTableViewBackground, shadowRadius: 1.0, shadowOpactiy: 1.0, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    weak var delegate: AddUserSubjectClassCellDelegate?
    var detailObj: AddNewSubjectClassModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        classLabel.text = "\(obj.subject_name) - \(obj.school_class)"
    }
    @objc func deleteAction() {
        guard let obj = detailObj else { return }
        ACRequest.POST_USER_SCHOOL_REMOVE_SUBJECT(userId: ACData.LOGINDATA.userID, schoolID: schoolID, yearID: ACData.DASHBOARDDATA.home_profile_year_id, schoolUserID: "", schoolSubjectTeacherID: obj.school_subject_teacher_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            ACData.SAVESUBJECTNEWDATA = results
            SVProgressHUD.dismiss()
            self.delegate?.refreshData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
