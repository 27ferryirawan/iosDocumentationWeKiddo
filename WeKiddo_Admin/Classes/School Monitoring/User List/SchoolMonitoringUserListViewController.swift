//
//  SchoolMonitoringUserListViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 31/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SchoolMonitoringUserListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var isStudent = Bool()
    var isParent = Bool()
    var isTeacher = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "School Monitoring", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "SchoolMonitoringUserListCell", bundle: nil), forCellReuseIdentifier: "schoolMonitoringHeaderUserListCellID")
        tableView.register(UINib(nibName: "SchoolMonitoringContentUserListCell", bundle: nil), forCellReuseIdentifier: "schoolMonitoringContentUserListCellID")
    }
}

extension SchoolMonitoringUserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isStudent {
            return 1 + ACData.TOTALSTUDENTDATA.count
        } else if isParent {
            return 1 + ACData.TOTALPARENTDATA.count
        } else {
            return 1 + ACData.TOTALTEACHERDATA.count
        }

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 33 : 66
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "schoolMonitoringHeaderUserListCellID", for: indexPath) as? SchoolMonitoringUserListCell)!
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "schoolMonitoringContentUserListCellID", for: indexPath) as? SchoolMonitoringContentUserListCell)!
            return cell
        }
    }
}
