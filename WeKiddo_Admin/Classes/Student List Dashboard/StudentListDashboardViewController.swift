//
//  StudentListDashboardViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class StudentListDashboardViewController: UIViewController {

    @IBOutlet weak var dataVerificationView: UIView! {
        didSet {
            dataVerificationView.layer.cornerRadius = dataVerificationView.frame.size.width / 2
            dataVerificationView.layer.masksToBounds = true
            dataVerificationView.backgroundColor = .blue
        }
    }
    @IBOutlet weak var registeredView: UIView! {
        didSet {
            registeredView.layer.cornerRadius = registeredView.frame.size.width / 2
            registeredView.layer.masksToBounds = true
            registeredView.backgroundColor = .orange
        }
    }
    @IBOutlet weak var implementedView: UIView! {
        didSet {
            implementedView.layer.cornerRadius = implementedView.frame.size.width / 2
            implementedView.layer.masksToBounds = true
            implementedView.backgroundColor = .green
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var isStudent = Bool()
    var isTeacher = Bool()
    var isParent = Bool()
    
    var currentDate = ""
    var yearID = ""
    var studentData = 0
    var teacherData = 0
    var parentData = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
        populateData()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Student", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Student", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "StudentDashboardContentCell", bundle: nil), forCellReuseIdentifier: "studentDashboardContentCellID")
        tableView.register(UINib(nibName: "TeacherDashboardContentCell", bundle: nil), forCellReuseIdentifier: "teacherDashboardContentCellID")
    }
    func populateData() {
        if isStudent {
            studentData = ACData.DASHBOARDCOORDINATORSTUDENTLISTDATA.count
        } else if isTeacher {
            teacherData = ACData.DASHBOARDCOORDINATORTEACHERLISTDATA.count
        } else {
            parentData = ACData.DASHBOARDCOORDINATORPARENTLISTDATA.count
        }
        tableView.reloadData()
    }
}
extension StudentListDashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isStudent {
            return studentData
        } else if isTeacher {
            return teacherData
        } else {
            return parentData
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "studentDashboardContentCellID", for: indexPath) as? StudentDashboardContentCell)!
        if isStudent {
            cell.detailObj = ACData.DASHBOARDCOORDINATORSTUDENTLISTDATA[indexPath.row]
        } else if isTeacher {
            cell.detailTeacherObj = ACData.DASHBOARDCOORDINATORTEACHERLISTDATA[indexPath.row]
        } else {
            cell.detailParentObj = ACData.DASHBOARDCOORDINATORPARENTLISTDATA[indexPath.row]
        }
        return cell
    }
}

extension StudentListDashboardViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 3 {
            print(searchText)
            if isStudent {
                fetchStudentDashboard(withKeyword: searchText)
            } else if isTeacher {
                fetchTeacherDashboard(withKeyword: searchText)
            } else {
                fetchParentDashboard(withKeyword: searchText)
            }
        }
    }
    
    func fetchParentDashboard(withKeyword: String) {
        ACData.DASHBOARDCOORDINATORPARENTLISTDATA.removeAll()
        ACRequest.POST_DASHBOARD_COORDINATOR_PARENT_LIST(userId: ACData.LOGINDATA.userID, date: currentDate, yearID: yearID, keyword: withKeyword, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            SVProgressHUD.dismiss()
            ACData.DASHBOARDCOORDINATORPARENTLISTDATA = results
            self.populateData()
            self.searchBar.resignFirstResponder()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    
    func fetchTeacherDashboard(withKeyword: String) {
        ACData.DASHBOARDCOORDINATORTEACHERLISTDATA.removeAll()
        ACRequest.POST_DASHBOARD_COORDINATOR_TEACHER_LIST(userId: ACData.LOGINDATA.userID, date: currentDate, yearID: yearID, keyword: withKeyword, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            SVProgressHUD.dismiss()
            ACData.DASHBOARDCOORDINATORTEACHERLISTDATA = results
            self.populateData()
            self.searchBar.resignFirstResponder()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    
    func fetchStudentDashboard(withKeyword: String) {
        ACData.DASHBOARDCOORDINATORSTUDENTLISTDATA.removeAll()
        ACRequest.POST_DASHBOARD_COORDINATOR_STUDENT_LIST(userId: ACData.LOGINDATA.userID, date: currentDate, yearID: yearID, keyword: withKeyword, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            SVProgressHUD.dismiss()
            ACData.DASHBOARDCOORDINATORSTUDENTLISTDATA = results
            self.populateData()
            self.searchBar.resignFirstResponder()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
