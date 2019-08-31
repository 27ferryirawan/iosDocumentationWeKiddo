//
//  SchoolMonitoringViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 29/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class SchoolMonitoringViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        fetchData()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "School Monitoring", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func fetchData() {
        ACRequest.POST_SCHOOL_MONITORING(userId: ACData.LOGINDATA.userID, schoolID: ACData.DASHBOARDDATA.home_profile_school_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
            ACData.SCHOOLMONITORINGDATA = result
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "SchoolMonitoringHeaderCell", bundle: nil), forCellReuseIdentifier: "schoolMonitoringHeaderCellID")
    }
}

extension SchoolMonitoringViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 692
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "schoolMonitoringHeaderCellID", for: indexPath) as? SchoolMonitoringHeaderCell)!
        cell.detailObj = ACData.SCHOOLMONITORINGDATA
        cell.delegate = self
        return cell
    }
}

extension SchoolMonitoringViewController: SchoolMonitoringHeaderCellDelegate {
    func refreshData() {
        self.tableView.reloadData()
    }
}
