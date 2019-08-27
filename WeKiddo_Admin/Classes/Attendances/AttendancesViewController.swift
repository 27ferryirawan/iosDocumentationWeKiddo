//
//  AttendancesViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 20/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class AttendancesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Attendance", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Attendance", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "AttendanceSubjectCell", bundle: nil), forCellReuseIdentifier: "attendanceSubjectCell")
    }
    func fetchData() {
        ACRequest.POST_ATTENDANCE_LIST(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (attendanceListData) in
            ACData.ATTENDANCEDATA = attendanceListData
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}

extension AttendancesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.ATTENDANCEDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "attendanceSubjectCell", for: indexPath) as? AttendanceSubjectCell)!
        cell.todayObj = ACData.ATTENDANCEDATA[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension AttendancesViewController: AttendanceSubjectCellDelegate {
    func toDetail() {
        let detailVC = AttendanceDetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
