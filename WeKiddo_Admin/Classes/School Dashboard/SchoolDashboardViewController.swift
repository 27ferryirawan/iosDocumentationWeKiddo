//
//  SchoolDashboardViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class SchoolDashboardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var currentDate = ""
    var yearID = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
        generateCurrentDate()
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
    func generateCurrentDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.currentDate = formatter.string(from: date)
        
        guard let yearIndexZero = ACData.LOGINDATA.dashboardSchoolMenu[0].year_id else {
            return
        }
        yearID = yearIndexZero
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
            cell.detailObj = ACData.DASHBOARDSCHOOLLISTDETAILDATA
            return cell
        } else if indexPath.row < 4 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "trackerContentCellID", for: indexPath) as? TrackerContentCell)!
            cell.index = indexPath.row
            cell.delegate = self
            cell.detailSchoolObj = ACData.DASHBOARDSCHOOLLISTDETAILDATA
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "trackerUserCellID", for: indexPath) as? TrackerUserCell)!
            cell.index = indexPath.row
            cell.delegate = self
            cell.detailSchoolObj = ACData.DASHBOARDSCHOOLLISTDETAILDATA
            return cell
        }
    }
}

extension SchoolDashboardViewController: TrackerContentCellDelegate, TrackerUserCellDelegate {
    func toDetailDashboard(withIndex: Int) {
        switch withIndex {
        case 4:
            fetchStudentDashboard()
        case 5:
            fetchTeacherDashboard()
        case 6:
            fetchParentDashboard()
        default:
            fetchStudentDashboard()
        }
    }
    
    func toDetailPage(withIndex: Int) {
        switch withIndex {
        case 1:
            self.fetchAssignmentDashboard()
        case 2:
            self.fetchEbookDashboard()
        case 3:
            self.fetchExerciseDashboard()
        default:
            self.fetchAssignmentDashboard()
        }
    }
    
    func fetchParentDashboard() {
        ACRequest.POST_DASHBOARD_COORDINATOR_PARENT_LIST(userId: ACData.LOGINDATA.userID, date: currentDate, yearID: yearID, keyword: "", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            SVProgressHUD.dismiss()
            ACData.DASHBOARDCOORDINATORPARENTLISTDATA = results
            let studentDashboard = StudentListDashboardViewController()
            studentDashboard.isStudent = false
            studentDashboard.isTeacher = false
            studentDashboard.isParent = true
            studentDashboard.currentDate = self.currentDate
            studentDashboard.yearID = self.yearID
            self.navigationController?.pushViewController(studentDashboard, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    
    func fetchTeacherDashboard() {
        ACRequest.POST_DASHBOARD_COORDINATOR_TEACHER_LIST(userId: ACData.LOGINDATA.userID, date: currentDate, yearID: yearID, keyword: "", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            SVProgressHUD.dismiss()
            ACData.DASHBOARDCOORDINATORTEACHERLISTDATA = results
            let studentDashboard = StudentListDashboardViewController()
            studentDashboard.isStudent = false
            studentDashboard.isTeacher = true
            studentDashboard.isParent = false
            studentDashboard.currentDate = self.currentDate
            studentDashboard.yearID = self.yearID
            self.navigationController?.pushViewController(studentDashboard, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    
    func fetchStudentDashboard() {
        ACRequest.POST_DASHBOARD_COORDINATOR_STUDENT_LIST(userId: ACData.LOGINDATA.userID, date: currentDate, yearID: yearID, keyword: "", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            SVProgressHUD.dismiss()
            ACData.DASHBOARDCOORDINATORSTUDENTLISTDATA = results
            let studentDashboard = StudentListDashboardViewController()
            studentDashboard.isStudent = true
            studentDashboard.isTeacher = false
            studentDashboard.isParent = false
            studentDashboard.currentDate = self.currentDate
            studentDashboard.yearID = self.yearID
            self.navigationController?.pushViewController(studentDashboard, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    
    func fetchAssignmentDashboard() {
        ACRequest.POST_DASHBOARD_COORDINATOR_ASSIGNMENT_LIST(userId: ACData.LOGINDATA.userID, date: currentDate, yearID: yearID, keyword: "", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            SVProgressHUD.dismiss()
            ACData.DASHBOARDCOORDINATORASSIGNMENTLISTDATA = results
            let dashboardAssignment = DashboardAssignmentViewController()
            dashboardAssignment.isAssignment = true
            dashboardAssignment.isEbook = false
            dashboardAssignment.isExercise = false
            dashboardAssignment.currentDate = self.currentDate
            dashboardAssignment.yearID = self.yearID
            self.navigationController?.pushViewController(dashboardAssignment, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    
    func fetchEbookDashboard() {
        ACRequest.POST_DASHBOARD_COORDINATOR_EBOOK_LIST(userId: ACData.LOGINDATA.userID, date: currentDate, yearID: yearID, keyword: "", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            SVProgressHUD.dismiss()
            ACData.DASHBOARDCOORDINATOREBOOKLISTDATA = results
            let dashboardAssignment = DashboardAssignmentViewController()
            dashboardAssignment.isAssignment = false
            dashboardAssignment.isEbook = true
            dashboardAssignment.isExercise = false
            dashboardAssignment.currentDate = self.currentDate
            dashboardAssignment.yearID = self.yearID
            self.navigationController?.pushViewController(dashboardAssignment, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    
    func fetchExerciseDashboard() {
        ACRequest.POST_DASHBOARD_COORDINATOR_EXERCISE_LIST(userId: ACData.LOGINDATA.userID, date: currentDate, yearID: yearID, keyword: "", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            SVProgressHUD.dismiss()
            ACData.DASHBOARDCOORDINATOREXERCISELISTDATA = results
            let dashboardAssignment = DashboardAssignmentViewController()
            dashboardAssignment.isAssignment = false
            dashboardAssignment.isEbook = false
            dashboardAssignment.isExercise = true
            dashboardAssignment.currentDate = self.currentDate
            dashboardAssignment.yearID = self.yearID
            self.navigationController?.pushViewController(dashboardAssignment, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
