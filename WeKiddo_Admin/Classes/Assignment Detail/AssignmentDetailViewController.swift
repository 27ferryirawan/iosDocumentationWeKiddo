//
//  AssignmentDetailViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 07/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class AssignmentDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeAssignmentView: UIView! {
        didSet {
            closeAssignmentView.setBorderShadow(color: UIColor.gray, shadowRadius: 1.0, shadowOpactiy: 1, shadowOffsetWidth: 1, shadowOffsetHeight: 1)
        }
    }
    @IBOutlet weak var closeAssignmentHeaderView: UIView!
    @IBOutlet weak var cancelAssignmentButton: UIButton! {
        didSet {
            cancelAssignmentButton.layer.cornerRadius = 5.0
            cancelAssignmentButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var closeAssignmentButton: UIButton! {
        didSet {
            closeAssignmentButton.layer.cornerRadius = 5.0
            closeAssignmentButton.layer.masksToBounds = true
        }
    }
    var closeAssignmentViewDisplayed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        updateView()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Assignment Detail", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Assignment Detail", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "AssignmentDetailViewCell", bundle: nil), forCellReuseIdentifier: "assignmentDetailViewCell")
        tableView.register(UINib(nibName: "AssignmentDetailClassCell", bundle: nil), forCellReuseIdentifier: "assignmentDetailClassCellID")
        tableView.register(UINib(nibName: "AssignmentDetailMenuCell", bundle: nil), forCellReuseIdentifier: "assignmentDetailMenuCellID")
        tableView.register(UINib(nibName: "AssignmentDetailFooterCell", bundle: nil), forCellReuseIdentifier: "assignmentDetailFooterCellID")
        cancelAssignmentButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        closeAssignmentButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    }
    @objc func cancelAction() {
        closeAssignmentViewDisplayed = false
        updateView()
    }
    @objc func closeAction() {
        ACRequest.POST_ASSIGNMENT_CLOSE(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, assignID: ACData.ASSIGNMENTDETAILDATA.assignment_id, classID: ACData.ASSIGNMENTDETAILDATA.school_class_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func updateView() {
        if closeAssignmentViewDisplayed {
            closeAssignmentView.isHidden = false
            closeAssignmentViewDisplayed = false
        } else {
            closeAssignmentView.isHidden = true
            closeAssignmentViewDisplayed = true
        }
    }
}

extension AssignmentDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 + ACData.ASSIGNMENTDETAILDATA.school_class_list.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 460
        } else if indexPath.row <= ACData.ASSIGNMENTDETAILDATA.school_class_list.count {
            return 44
        } else if indexPath.row == ACData.ASSIGNMENTDETAILDATA.school_class_list.count + 1 {
            return 90
        } else {
            return 55
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "assignmentDetailViewCell", for: indexPath) as? AssignmentDetailViewCell)!
            cell.assignmentObj = ACData.ASSIGNMENTDETAILDATA
            return cell
        } else if indexPath.row <= ACData.ASSIGNMENTDETAILDATA.school_class_list.count {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "assignmentDetailClassCellID", for: indexPath) as? AssignmentDetailClassCell)!
            cell.detailObj = ACData.ASSIGNMENTDETAILDATA.school_class_list[indexPath.row - 1]
            return cell
        } else if indexPath.row == ACData.ASSIGNMENTDETAILDATA.school_class_list.count + 1 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "assignmentDetailMenuCellID", for: indexPath) as? AssignmentDetailMenuCell)!
            cell.assignmentObj = ACData.ASSIGNMENTDETAILDATA
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "assignmentDetailFooterCellID", for: indexPath) as? AssignmentDetailFooterCell)!
            cell.delegate = self
            return cell
        }
    }
}

extension AssignmentDetailViewController: AssignmentDetailMenuCellDelegate, AssignmentDetailFooterCellDelegate {
    func closeAssignment() {
        closeAssignmentViewDisplayed = true
        updateView()
    }
    func editAction() {
        ACRequest.POST_SUBJECT_LIST(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (subjectDatas) in
            ACData.SUBJECTDATA = subjectDatas
            SVProgressHUD.dismiss()
            let addNewVC = AddNewAssignmentViewController()
            addNewVC.isFromEdit = true
            self.navigationController?.pushViewController(addNewVC, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func toStudentNote() {
    }
    func toAttachment() {
        print("assss")
        let attachmentVC = AttachmentViewController()
        attachmentVC.assignID = ACData.ASSIGNMENTDETAILDATA.assignment_id
        self.navigationController?.pushViewController(attachmentVC, animated: true)
    }
    func toScore() {
        let scoreVC = AssignmentScoresViewController()
        self.navigationController?.pushViewController(scoreVC, animated: true)
    }
}
