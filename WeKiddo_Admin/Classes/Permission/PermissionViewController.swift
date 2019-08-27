//
//  PermissionViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 04/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class PermissionViewController: UIViewController {

    @IBOutlet weak var rejectView: UIView!
    @IBOutlet weak var approveView: UIView!
    @IBOutlet weak var pendingView: UIView!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var pendingButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var isPending = true
    var isApprove = false
    var isReject = false
    var pendingData = 0
    var approveData = 0
    var rejectData = 0
    var keyword = ""
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        configTable()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if (self != self.navigationController?.viewControllers[0]) {
            backStyleNavigationController(pageTitle: "Permission Request", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Permission Request", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        }
    }
    func fetchData() {
        ACRequest.POST_PERMISSION_LIST(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (permissionData) in
            ACData.PERMISSIONDATA = permissionData
            if permissionData.permissionPending.count != 0 {
                self.pendingData = ACData.PERMISSIONDATA.permissionPending.count
            } else {
                self.pendingData = 0
            }
            if permissionData.permissionReject.count != 0 {
                self.rejectData = ACData.PERMISSIONDATA.permissionReject.count
            } else {
                self.rejectData = 0
            }
            if permissionData.permissionApprove.count != 0 {
                self.approveData = ACData.PERMISSIONDATA.permissionApprove.count
            } else {
                self.approveData = 0
            }
            SVProgressHUD.dismiss()
            self.updateView()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "PermissionContentCell", bundle: nil), forCellReuseIdentifier: "permissionContentCellID")
    }
    @IBAction func pendingAction(_ sender: UIButton) {
        isPending = true
        isApprove = false
        isReject = false
        updateView()
    }
    @IBAction func approveAction(_ sender: UIButton) {
        isPending = false
        isApprove = true
        isReject = false
        updateView()
    }
    @IBAction func rejectAction(_ sender: UIButton) {
        isPending = false
        isApprove = false
        isReject = true
        updateView()
    }
    func updateView() {
        pendingButton.setTitle("Pending \(ACData.PERMISSIONDATA.permissionPending.count)", for: .normal)
        approveButton.setTitle("Approve \(ACData.PERMISSIONDATA.permissionApprove.count)", for: .normal)
        rejectButton.setTitle("Reject \(ACData.PERMISSIONDATA.permissionReject.count)", for: .normal)
        if isPending {
            pendingButton.setTitle("Pending \(ACData.PERMISSIONDATA.permissionPending.count)", for: .normal)
            pendingView.backgroundColor = ACColor.MAIN
            approveView.backgroundColor = .clear
            rejectView.backgroundColor = .clear
        } else if isApprove {
            approveButton.setTitle("Approve \(ACData.PERMISSIONDATA.permissionApprove.count)", for: .normal)
            pendingView.backgroundColor = .clear
            approveView.backgroundColor = ACColor.MAIN
            rejectView.backgroundColor = .clear
        } else {
            rejectButton.setTitle("Reject \(ACData.PERMISSIONDATA.permissionReject.count)", for: .normal)
            pendingView.backgroundColor = .clear
            approveView.backgroundColor = .clear
            rejectView.backgroundColor = ACColor.MAIN
        }
        tableView.reloadData()
    }
    func searchPermission() {
        ACRequest.POST_SEARCH_PERMISSION_LIST(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, key: keyword, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (permissionData) in
            ACData.PERMISSIONDATA = permissionData
            SVProgressHUD.dismiss()
            self.pendingData = ACData.PERMISSIONDATA.permissionPending.count
            self.approveData = ACData.PERMISSIONDATA.permissionApprove.count
            self.rejectData = ACData.PERMISSIONDATA.permissionReject.count
            self.updateView()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}

extension PermissionViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isPending {
            return pendingData
        } else if isApprove {
            return approveData
        } else {
            return rejectData
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "permissionContentCellID", for: indexPath) as? PermissionContentCell)!
        cell.configCell(index: indexPath.row, isPending:self.isPending, isApprove:self.isApprove, isReject:self.isReject)
        cell.delegate = self
        return cell
    }
}

extension PermissionViewController: PermissionContentCellDelegate, UISearchBarDelegate {
    func toDetail() {
        let permissionDetailVC = PermissionRequestDetailViewController()
        self.navigationController?.pushViewController(permissionDetailVC, animated: true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        keyword = searchBar.text!
        searchPermission()
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
}
