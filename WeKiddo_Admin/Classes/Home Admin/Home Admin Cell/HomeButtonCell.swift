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
    func toAssignmentList()
    func toPermissionList()
    func toDetentionList()
    func toEventList()
    func toLatePaymentList()
    func toSpecialAttentionList()
    func toCurrentClassList()
}

class HomeButtonCell: UITableViewCell {

    @IBOutlet weak var buttonSection: UIButton!{
        didSet {
            buttonSection.layer.cornerRadius = 5
            buttonSection.clipsToBounds = true
        }
    }
    private var isAssignment = Bool()
    private var isPermission = Bool()
    private var isCurrentClass = Bool()
    private var isSpecialAttentionByClass = Bool()
    private var isSpecialAttentionBySubject = Bool()
    private var isDetention = Bool()
    private var isEvent = Bool()
    private var isLatePayment = Bool()
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
    func cellHomeroomConfig(isAssignment: Bool, isPermission: Bool, isCurrentClass: Bool, isSpecialAttentionByClass: Bool, isSpecialAttentionBySubject: Bool, isDetention: Bool) {
        if isAssignment {
            buttonSection.setTitle("SEE MORE ASSIGNMENT(s)", for: .normal)
            self.isAssignment = isAssignment
        } else if isPermission {
            buttonSection.setTitle("SEE MORE PERMISSION REQUEST", for: .normal)
            self.isPermission = isPermission
        } else if isCurrentClass {
            buttonSection.setTitle("SEE MORE", for: .normal)
            self.isCurrentClass = isCurrentClass
        } else if isSpecialAttentionByClass {
            self.isSpecialAttentionByClass = isSpecialAttentionByClass
            buttonSection.setTitle("SEE MORE", for: .normal)
        } else if isSpecialAttentionBySubject {
            self.isSpecialAttentionBySubject = isSpecialAttentionBySubject
            buttonSection.setTitle("SEE MORE", for: .normal)
        } else if isDetention {
            self.isDetention = isDetention
            buttonSection.setTitle("SEE MORE", for: .normal)
        }
    }
    func cellConfig(isEvent: Bool, isLatePayment: Bool, isPermission: Bool) {
        if isEvent {
            self.isEvent = isEvent
            buttonSection.setTitle("MORE EVENT", for: .normal)
        } else if isLatePayment {
            self.isLatePayment = isLatePayment
             buttonSection.setTitle("SEE ALL LATE PAYMENT", for: .normal)
        } else if isPermission {
            self.isPermission = isPermission
            buttonSection.setTitle("SEE ALL PERMISSION REQUEST", for: .normal)
        }
    }
}
