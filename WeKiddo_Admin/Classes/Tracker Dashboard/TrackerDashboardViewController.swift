//
//  TrackerDashboardViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

class TrackerDashboardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Dashboard", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Dashboard", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "TrackerDashboardHeaderCell", bundle: nil), forCellReuseIdentifier: "trackerDashboardHeaderCellID")
        tableView.register(UINib(nibName: "TrackerContentCell", bundle: nil), forCellReuseIdentifier: "trackerContentCellID")
        tableView.register(UINib(nibName: "TrackerUserCell", bundle: nil), forCellReuseIdentifier: "trackerUserCellID")
    }

}
extension TrackerDashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 70
        } else if indexPath.row < 4 {
            return 120
        } else {
            return 180
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "trackerDashboardHeaderCellID", for: indexPath) as? TrackerDashboardHeaderCell)!
            cell.delegate = self
            return cell
        } else if indexPath.row < 4 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "trackerContentCellID", for: indexPath) as? TrackerContentCell)!
            cell.index = indexPath.row
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "trackerUserCellID", for: indexPath) as? TrackerUserCell)!
            cell.index = indexPath.row
            cell.delegate = self
            return cell
        }
    }
}

extension TrackerDashboardViewController: TrackerDashboardHeaderCellDelegate, TrackerContentCellDelegate, TrackerUserCellDelegate {
    func toDetailDashboard(withIndex: Int) {
        switch withIndex {
        case 4:
            let studentDashboard = StudentListDashboardViewController()
            studentDashboard.isStudent = true
            studentDashboard.isTeacher = false
            studentDashboard.isParent = false
            self.navigationController?.pushViewController(studentDashboard, animated: true)
        case 5:
            let studentDashboard = StudentListDashboardViewController()
            studentDashboard.isStudent = false
            studentDashboard.isTeacher = true
            studentDashboard.isParent = false
            self.navigationController?.pushViewController(studentDashboard, animated: true)
        case 6:
            let studentDashboard = StudentListDashboardViewController()
            studentDashboard.isStudent = false
            studentDashboard.isTeacher = false
            studentDashboard.isParent = true
            self.navigationController?.pushViewController(studentDashboard, animated: true)
        default:
            let studentDashboard = StudentListDashboardViewController()
            studentDashboard.isStudent = true
            studentDashboard.isTeacher = false
            studentDashboard.isParent = false
            self.navigationController?.pushViewController(studentDashboard, animated: true)
        }
    }
    
    func toDetailPage(withIndex: Int) {
        switch withIndex {
        case 1:
            let dashboardAssignment = DashboardAssignmentViewController()
            dashboardAssignment.isAssignment = true
            dashboardAssignment.isEbook = false
            dashboardAssignment.isExercise = false
            self.navigationController?.pushViewController(dashboardAssignment, animated: true)
        case 2:
            let dashboardAssignment = DashboardAssignmentViewController()
            dashboardAssignment.isAssignment = false
            dashboardAssignment.isEbook = true
            dashboardAssignment.isExercise = false
            self.navigationController?.pushViewController(dashboardAssignment, animated: true)
        case 3:
            let dashboardAssignment = DashboardAssignmentViewController()
            dashboardAssignment.isAssignment = false
            dashboardAssignment.isEbook = false
            dashboardAssignment.isExercise = true
            self.navigationController?.pushViewController(dashboardAssignment, animated: true)
        default:
            let dashboardAssignment = DashboardAssignmentViewController()
            self.navigationController?.pushViewController(dashboardAssignment, animated: true)
        }
    }
    
    func toTotalSchoolPage() {
        let totalSchoolVC = TotalSchoolViewController()
        self.navigationController?.pushViewController(totalSchoolVC, animated: true)
    }
}
