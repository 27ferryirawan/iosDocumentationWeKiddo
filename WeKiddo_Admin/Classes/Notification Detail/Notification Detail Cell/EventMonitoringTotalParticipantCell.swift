//
//  EventMonitoringTotalParticipantCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 27/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SVProgressHUD
import Alamofire

protocol EventMonitoringTotalParticipantCellDelegate: class {
    func refreshData()
    func toEditEvent()
    func toPaymentPage()
}

class EventMonitoringTotalParticipantCell: UITableViewCell {

    @IBOutlet weak var paidBgView: UIView! {
        didSet {
            paidBgView.layer.cornerRadius = paidBgView.frame.size.width / 2
            paidBgView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var rejectBgView: UIView! {
        didSet {
            rejectBgView.layer.cornerRadius = rejectBgView.frame.size.width / 2
            rejectBgView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var approveBgView: UIView! {
        didSet {
            approveBgView.layer.cornerRadius = approveBgView.frame.size.width / 2
            approveBgView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var pendingBgView: UIView! {
        didSet {
            pendingBgView.layer.cornerRadius = pendingBgView.frame.size.width / 2
            pendingBgView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var editEventButton: UIButton! {
        didSet {
            editEventButton.layer.cornerRadius = 5.0
            editEventButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var paymentButton: UIButton! {
        didSet {
            paymentButton.layer.cornerRadius = 5.0
            paymentButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var selectedPaidView: UIView! {
        didSet {
            selectedPaidView.layer.cornerRadius = selectedPaidView.frame.size.width / 2
            selectedPaidView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var selectedRejectView: UIView! {
        didSet {
            selectedRejectView.layer.cornerRadius = selectedRejectView.frame.size.width / 2
            selectedRejectView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var selectedApproveView: UIView! {
        didSet {
            selectedApproveView.layer.cornerRadius = selectedApproveView.frame.size.width / 2
            selectedApproveView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var selectedPendingView: UIView! {
        didSet {
            selectedPendingView.layer.cornerRadius = selectedPendingView.frame.size.width / 2
            selectedPendingView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var classView: UIView! {
        didSet {
            classView.setBorderShadow(color: UIColor.lightGray, shadowRadius: 2.0, shadowOpactiy: 0.5, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    @IBOutlet weak var selectClassButton: UIButton!
    @IBOutlet weak var paidLabel: UILabel!
    @IBOutlet weak var rejectLabel: UILabel!
    @IBOutlet weak var approveLabel: UILabel!
    @IBOutlet weak var pendingLabel: UILabel!
    
    @IBOutlet weak var selectedPaidLabel: UILabel!
    @IBOutlet weak var selectedRejectLabel: UILabel!
    @IBOutlet weak var selectedApproveLabel: UILabel!
    @IBOutlet weak var selectedPendingLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    var classArray = [String]()
    var classID = ""
    weak var delegate: EventMonitoringTotalParticipantCellDelegate?
    var detailObj: ApprovalDetailModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectClassButton.addTarget(self, action: #selector(showClassPicker), for: .touchUpInside)
        editEventButton.addTarget(self, action: #selector(editEventAction), for: .touchUpInside)
        paymentButton.addTarget(self, action: #selector(toPayment), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        pendingLabel.text = "\(obj.count_pending)"
        approveLabel.text = "\(obj.count_approve)"
        rejectLabel.text = "\(obj.count_reject)"
        paidLabel.text = "\(obj.count_paid)"
        for item in obj.list_class {
            classArray.append(item.school_class)
        }
        guard let object = ACData.EVENTCOUNTDATA else {
            return
        }
        selectedPendingLabel.text = "\(object.count_pending)"
        selectedPaidLabel.text = "\(object.count_paid)"
        selectedApproveLabel.text = "\(object.count_approve)"
        selectedRejectLabel.text = "\(object.count_reject)"
        teacherLabel.text = object.teacher_name
        classLabel.text = object.school_class
    }
    @objc func toPayment() {
        self.delegate?.toPaymentPage()
    }
    @objc func editEventAction() {
        self.delegate?.toEditEvent()
    }
    @objc func showClassPicker() {
        guard let obj = detailObj else { return }
        ActionSheetStringPicker.show(
            withTitle: "- Select Class -",
            rows: classArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.selectClassButton.setTitle(value, for: .normal)
                self.classID = obj.list_class[indexes].school_class_id
                self.getEventCount()
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    func getEventCount() {
        guard let obj = detailObj else { return }
        ACRequest.POST_ADMIN_EVENT_COUNT_BY_CLASS(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, eventID: obj.event_id, schoolClassID: self.classID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonData) in
            ACData.EVENTCOUNTDATA = jsonData
            SVProgressHUD.dismiss()
            self.delegate?.refreshData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
