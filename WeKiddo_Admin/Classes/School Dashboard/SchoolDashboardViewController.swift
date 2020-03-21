//
//  SchoolDashboardViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SchoolDashboardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "School Monitoring", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "School Monitoring", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "SchoolDashboardHeaderCell", bundle: nil), forCellReuseIdentifier: "schoolDashboardHeaderCellID")
        tableView.register(UINib(nibName: "TrackerContentCell", bundle: nil), forCellReuseIdentifier: "trackerContentCellID")
        tableView.register(UINib(nibName: "TrackerUserCell", bundle: nil), forCellReuseIdentifier: "trackerUserCellID")
    }

}
extension SchoolDashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 140
        } else if indexPath.row < 4 {
            return 120
        } else {
            return 180
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "schoolDashboardHeaderCellID", for: indexPath) as? SchoolDashboardHeaderCell)!
            return cell
        } else if indexPath.row < 4 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "trackerContentCellID", for: indexPath) as? TrackerContentCell)!
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "trackerUserCellID", for: indexPath) as? TrackerUserCell)!
            return cell
        }
    }
}
