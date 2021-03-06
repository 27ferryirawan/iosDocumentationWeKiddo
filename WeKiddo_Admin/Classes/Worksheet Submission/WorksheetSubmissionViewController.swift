//
//  WorksheetSubmissionViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

class WorksheetSubmissionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Worksheet Submission", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Worksheet Submission", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "WorksheetSubmissionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "WorksheetSubmissionHeaderView")
        tableView.register(UINib(nibName: "WorksheetStudentCell", bundle: nil), forCellReuseIdentifier: "worksheetStudentCellID")
    }

}
extension WorksheetSubmissionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "WorksheetSubmissionHeaderView") as! WorksheetSubmissionHeaderView
        headerView.detailObj = ACData.COORDINATORASSIGNMENTLISTPERCLASS[section]
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.COORDINATORASSIGNMENTLISTPERCLASS[0].student_lists.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "worksheetStudentCellID", for: indexPath) as? WorksheetStudentCell)!
        cell.detailObj = ACData.COORDINATORASSIGNMENTLISTPERCLASS[indexPath.section].student_lists[indexPath.row]
        if indexPath.row % 2 == 0 {
            cell.bgView.backgroundColor = .groupTableViewBackground
        } else {
            cell.bgView.backgroundColor = .white
        }
        return cell
    }
}
