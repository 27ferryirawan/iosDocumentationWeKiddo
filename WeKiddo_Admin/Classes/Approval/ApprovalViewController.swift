//
//  ApprovalViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 05/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class ApprovalViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        fetchData()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Approval", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Approval", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func fetchData() {
        ACData.APPROVAL.removeAll()
        ACRequest.GET_APPROVAL_DATA(childID: /*ACData.HOMEDATA.childID*/"C1", successCompletion: { (approvalData) in
            ACData.APPROVAL = approvalData
            print("approval data: \(ACData.APPROVAL)")
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "ApprovalSectionCell", bundle: nil), forCellReuseIdentifier: "approvalSectionCell")
        tableView.register(UINib(nibName: "ApprovalContentCell", bundle: nil), forCellReuseIdentifier: "approvalContentCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ApprovalViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("approval data  :  \(ACData.APPROVAL.count)")
        return 1 + ACData.APPROVAL.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 35 : 66
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "approvalSectionCell", for: indexPath) as? ApprovalSectionCell)!
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "approvalContentCell", for: indexPath) as? ApprovalContentCell)!
            cell.approvalObjc = ACData.APPROVAL[indexPath.row-1]
            cell.delegate = self
            return cell
        }
    }
}

extension ApprovalViewController: ApprovalContentCellDelegate {
    func goToDetail() {
        let approvalDetailVC = NotificationDetailViewController()
        approvalDetailVC.isApproval = true
        self.navigationController?.pushViewController(approvalDetailVC, animated: true)
    }
}
