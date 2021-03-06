//
//  AssignmentDetailFooterCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 05/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AssignmentDetailFooterCellDelegate: class {
    func closeAssignment()
    func editAction()
}

class AssignmentDetailFooterCell: UITableViewCell {
    
    weak var delegate: AssignmentDetailFooterCellDelegate?

    @IBOutlet weak var closeAssignmentButton: UIButton! {
        didSet {
            closeAssignmentButton.layer.cornerRadius = 5.0
            closeAssignmentButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var editAssignmentButton: UIButton! {
        didSet {
            editAssignmentButton.layer.cornerRadius = 5.0
            editAssignmentButton.layer.masksToBounds = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        editAssignmentButton.addTarget(self, action: #selector(editActionAssignment), for: .touchUpInside)
        closeAssignmentButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func editActionAssignment() {
        // TODO: Change Value of Teacher ID
        guard let teacherID = ACData.ASSIGNMENTTEACHERLISTALL.assignmentTeacherList.first(where: {$0.teacher_name ==  ACData.ASSIGNMENTDETAILDATA.teacher_name})?.teacher_id else { return }
        ACRequest.POST_DETAIL_ASSIGNMENT_FOR_EDIT(
            userId: ACData.LOGINDATA.userID,
            school_user_id: teacherID,
            assignID: ACData.ASSIGNMENTDETAILDATA.assignment_id,
            school_id: ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
            year_id: ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
            tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (datas) in
            SVProgressHUD.dismiss()
            ACData.ASSIGNMENTDETAILEDITDATA = datas
            self.delegate?.editAction()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func closeAction() {
        self.delegate?.closeAssignment()
    }
}
