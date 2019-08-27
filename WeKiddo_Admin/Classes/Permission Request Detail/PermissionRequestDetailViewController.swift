//
//  PermissionRequestDetailViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 01/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

class PermissionRequestDetailViewController: UIViewController {
    
    @IBOutlet weak var confirmationButton: UIButton!
    @IBOutlet weak var confirmationTextview: UITextView!
    @IBOutlet weak var confirmationDate: UILabel!
    @IBOutlet weak var confirmationCloseButton: UIButton!
    @IBOutlet weak var confirmationTitleLabel: UILabel!
    @IBOutlet weak var confirmationView: UIView! {
        didSet {
            confirmationView.setBorderShadow(color: UIColor.gray, shadowRadius: 1.0, shadowOpactiy: 1, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    @IBOutlet weak var attachmentImage: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var attachmentView: UIView! {
        didSet {
            attachmentView.setBorderShadow(color: UIColor.gray, shadowRadius: 1.0, shadowOpactiy: 1, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var grayAreaBtn: UIButton!{
        didSet{
            grayAreaBtn.isHidden = true
            grayAreaBtn.backgroundColor = UIColor(displayP3Red: 102/255, green: 102/255, blue: 102/255, alpha: 0.8)
        }
    }
    var isAttachmentDisplayed = false
    var isConfirmationDisplayed = false
    var attachmentImageURL = ""
    var permissionStatus = 0
    var permissionID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Permission Request", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        attachmentView.isHidden = true
        confirmationView.isHidden = true
        confirmationTextview.text = "Reason"
        confirmationTextview.textColor = UIColor.lightGray
        tableView.register(UINib(nibName: "PermissionRequestDetailCell", bundle: nil), forCellReuseIdentifier: "permissionRequestDetailCellID")
        tableView.register(UINib(nibName: "PermissionRequestAttachmentCell", bundle: nil), forCellReuseIdentifier: "permissionRequestAttachmentCellID")
        tableView.register(UINib(nibName: "PermissionRequestFooterCell", bundle: nil), forCellReuseIdentifier: "permissionRequestFooterCellID")
        closeButton.addTarget(self, action: #selector(closeAttachmentView), for: .touchUpInside)
        confirmationCloseButton.addTarget(self, action: #selector(closeConfirmationView), for: .touchUpInside)
        confirmationButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    }
    func updateView() {
        if isAttachmentDisplayed {
            attachmentView.isHidden = false
            attachmentImage.sd_setImage(
                with: URL(string: attachmentImageURL),
                placeholderImage: UIImage(named: "WeKiddoLogo"),
                options: .refreshCached
            )
        } else {
            attachmentView.isHidden = true
        }
        
        if isConfirmationDisplayed {
            confirmationView.isHidden = false
        } else {
            confirmationView.isHidden = true
        }
    }
    @objc func closeAttachmentView() {
        isAttachmentDisplayed = false
        updateView()
    }
    @objc func closeConfirmationView() {
        isConfirmationDisplayed = false
        updateView()
    }
    @objc func confirmAction() {
        print(confirmationTextview.text!)
        ACRequest.POST_UPDATE_PERMISSION(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, permissionID: permissionID, tokenAccess: ACData.LOGINDATA.accessToken, action: permissionStatus, reason: confirmationTextview.text!, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension PermissionRequestDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + ACData.PERMISSIONDETAILDATA.medias.count // replace from attachment files
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 255
        } else if indexPath.row < 1 + ACData.PERMISSIONDETAILDATA.medias.count {
            return 40
        } else {
            return 205
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "permissionRequestDetailCellID", for: indexPath) as? PermissionRequestDetailCell)!
            cell.permissionObj = ACData.PERMISSIONDETAILDATA
            return cell
        } else if indexPath.row < 1 + ACData.PERMISSIONDETAILDATA.medias.count {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "permissionRequestAttachmentCellID", for: indexPath) as? PermissionRequestAttachmentCell)!
            if ACData.PERMISSIONDETAILDATA.medias.count != 0 {
                cell.mediaObj = ACData.PERMISSIONDETAILDATA.medias[indexPath.row - 1]
            } else {
                // do nothing
            }
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "permissionRequestFooterCellID", for: indexPath) as? PermissionRequestFooterCell)!
            cell.detailObj = ACData.PERMISSIONDETAILDATA
            if cell.detailObj?.permission_status == 0{
                cell.approveButton.isHidden = false
                cell.rejectButton.isHidden = false
            } else{
                cell.approveButton.isHidden = true
                cell.rejectButton.isHidden = true
            }
            cell.delegate = self
            return cell
        }
    }
}

extension PermissionRequestDetailViewController: PermissionRequestAttachmentCellDelegate, PermissionRequestFooterCellDelegate {
    func displayAttachment(withUrl: String) {
        isAttachmentDisplayed = true
        attachmentImageURL = withUrl
        updateView()
    }
    func rejectAction(status: Int, withPermissionID: String) {
        isConfirmationDisplayed = true
        permissionStatus = status
        permissionID = withPermissionID
        updateView()
    }
    func approveAction(status: Int, withPermissionID: String) {
        isConfirmationDisplayed = true
        permissionStatus = status
        permissionID = withPermissionID
        updateView()
    }
}

extension PermissionRequestDetailViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Reason"
            textView.textColor = UIColor.lightGray
        }
    }
}
