//
//  HomeButtonCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol HomeButtonCellDelegate: class {
    func toTaskList()
    func toAbsentCheckList()
    func toSessionCheckList()
}

class HomeButtonCell: UITableViewCell {

    @IBOutlet weak var buttonSection: UIButton!{
        didSet {
            buttonSection.layer.cornerRadius = 5
            buttonSection.clipsToBounds = true
        }
    }
    private var isTaskList = Bool()
    private var isAbsentCheckList = Bool()
    private var isSessionChecList = Bool()
    weak var delegate: HomeButtonCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func toDetail() {
        /*
        print("isAssignment: \(isAssignment), isPermission: \(isPermission), isCurrentClass: \(isCurrentClass), isSpecialAttention: \(isSpecialAttention), isDetention: \(isDetention)")
        if isAssignment {
            self.delegate?.toAssignmentList()

//            ACRequest.POST_ASSIGNMENT_LIST(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, subjectID: "", classID: "", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (assignmentDatas) in
//                SVProgressHUD.dismiss()
//                ACData.ASSIGNMENTLIST = assignmentDatas
//                self.delegate?.toAssignmentList()
//            }) { (message) in
//                SVProgressHUD.dismiss()
//            }
        } else if isPermission {
            self.delegate?.toPermissionList()
        } else if isCurrentClass {
            ACRequest.POST_CURRENT_SESSION_MORE(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, page: 1, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
                SVProgressHUD.dismiss()
                ACData.CURRENTCLASSLISTDATA = jsonDatas
                self.delegate?.toCurrentClassList()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else if isSpecialAttention {
            ACRequest.POST_TEACHER_SPECIAL_ATTENTION_BY_SUBJECT(userId: ACData.LOGINDATA.userID, schoolID: ACData.LOGINDATA.school_id, role: ACData.LOGINDATA.role, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
                SVProgressHUD.dismiss()
                ACData.SPECIALATTENTIONBYSUBJECTDATA = jsonDatas
                self.delegate?.toSpecialAttentionList()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else if isDetention {
            self.delegate?.toDetentionList()
        } else if isEvent {
            ACRequest.POST_ADMIN_GET_MORE_EVENT(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
                ACData.ADMINEVENTLISTDATA = jsonDatas
                SVProgressHUD.dismiss()
                self.delegate?.toEventList()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else if isLatePayment {
            ACRequest.POST_LATE_PAYMENT_LIST(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
                ACData.LATEPAYMENTLISTDATA = jsonDatas
                SVProgressHUD.dismiss()
                self.delegate?.toLatePaymentList()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        }
        */
    }
    func cellHomeroomConfig(isTaskList: Bool, isAbsentCheckList: Bool, isSessionCheckList: Bool) {
        if isTaskList {
            buttonSection.setTitle("SEE All(s)", for: .normal)
            self.isTaskList = isTaskList
        } else if isAbsentCheckList {
            buttonSection.setTitle("SEE ALL(s)", for: .normal)
            self.isAbsentCheckList = isAbsentCheckList
        } else {
            self.isSessionChecList = isSessionCheckList
            buttonSection.setTitle("SEE ALL(s)", for: .normal)
        }
    }
}
