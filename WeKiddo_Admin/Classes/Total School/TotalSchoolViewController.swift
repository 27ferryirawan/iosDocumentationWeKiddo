//
//  TotalSchoolViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

class TotalSchoolViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var schoolID = ""
    var date = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Total School", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Total School", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "TotalSchoolHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "TotalSchoolHeaderView")
        tableView.register(UINib(nibName: "TotalSchoolContentCell", bundle: nil), forCellReuseIdentifier: "totalSchoolContentCellID")
    }

}
extension TotalSchoolViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ACData.DASHBOARDCOORDINATORSCHOOLLISTDATA.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TotalSchoolHeaderView") as! TotalSchoolHeaderView
        headerView.titleLabel.text = ACData.DASHBOARDCOORDINATORSCHOOLLISTDATA[section].school_grade
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "totalSchoolContentCellID", for: indexPath) as? TotalSchoolContentCell)!
        cell.indexSection = indexPath.section
        cell.date = self.date
        cell.delegate = self
        return cell
    }
}

extension TotalSchoolViewController: TotalSchoolContentCellDelegate {
    func toSchoolDashboard() {
        let schoolDashboard = SchoolDashboardViewController()
        self.navigationController?.pushViewController(schoolDashboard, animated: true)
    }
}
