//
//  DashboardAssignmentViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class DashboardAssignmentViewController: UIViewController {

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
    
    var isAssignment = Bool()
    var isEbook = Bool()
    var isExercise = Bool()
    
    var currentDate = ""
    var yearID = ""
    var assignmentData = 0
    var ebookData = 0
    var exerciseData = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
        populateData()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Assignment", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Assignment", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "DashboardAssignmentContentCell", bundle: nil), forCellReuseIdentifier: "dashboardAssignmentContentCellID")
    }
    func populateData() {
        if isAssignment {
            assignmentData = ACData.DASHBOARDCOORDINATORASSIGNMENTLISTDATA.count
        } else if isEbook {
            ebookData = ACData.DASHBOARDCOORDINATOREBOOKLISTDATA.count
        } else {
            exerciseData = ACData.DASHBOARDCOORDINATOREXERCISELISTDATA.count
        }
        tableView.reloadData()
    }
}
extension DashboardAssignmentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isAssignment {
            return assignmentData
        } else if isEbook {
            return ebookData
        } else {
            return exerciseData
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "dashboardAssignmentContentCellID", for: indexPath) as? DashboardAssignmentContentCell)!
        cell.delegate = self
        cell.currentDate = self.currentDate
        cell.yearID = self.yearID
        if isAssignment {
            cell.isAssignment = self.isAssignment
            cell.detailAssignmentObj = ACData.DASHBOARDCOORDINATORASSIGNMENTLISTDATA[indexPath.row]
        } else if isEbook {
            cell.isEbook = self.isEbook
            cell.detailEbookObj = ACData.DASHBOARDCOORDINATOREBOOKLISTDATA[indexPath.row]
        } else {
            cell.isExercise = self.isExercise
            cell.detailExerciseObj = ACData.DASHBOARDCOORDINATOREXERCISELISTDATA[indexPath.row]
        }
        return cell
    }
}

extension DashboardAssignmentViewController: DashboardAssignmentContentCellDelegate {
    func toAssignmentList() {
        let assignmentListVC = AssignmentListViewController()
        self.navigationController?.pushViewController(assignmentListVC, animated: true)
    }
    
    func toEbookUploadList() {
        let ebookListVC = EbookListViewController()
        self.navigationController?.pushViewController(ebookListVC, animated: true)
    }
    
    func toEbookDownloadList() {
        let ebookDonlodListVc = EBookDownloadedViewController()
        self.navigationController?.pushViewController(ebookDonlodListVc, animated: true)
    }
    
    func toExerciseSchoolCreate(withSchoolID: String) {
        let exerciseCreate = ExerciseListViewController()
        exerciseCreate.schoolID = withSchoolID
        self.navigationController?.pushViewController(exerciseCreate, animated: true)
    }
    
    func toExerciseStudentDo() {
        let exerciseStudentDo = StudentDoExerciseViewController()
        self.navigationController?.pushViewController(exerciseStudentDo, animated: true)
    }
}

extension DashboardAssignmentViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 3 {
            print(searchText)
            if isAssignment {
                fetchAssignmentDashboard(withKeyword: searchText)
            } else if isEbook {
                fetchEbookDashboard(withKeyword: searchText)
            } else {
                fetchExerciseDashboard(withKeyword: searchText)
            }
        }
    }
    
    func fetchAssignmentDashboard(withKeyword: String) {
        ACData.DASHBOARDCOORDINATORASSIGNMENTLISTDATA.removeAll()
        ACRequest.POST_DASHBOARD_COORDINATOR_ASSIGNMENT_LIST(userId: ACData.LOGINDATA.userID, date: currentDate, yearID: yearID, keyword: withKeyword, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            SVProgressHUD.dismiss()
            ACData.DASHBOARDCOORDINATORASSIGNMENTLISTDATA = results
            self.searchBar.resignFirstResponder()
            self.populateData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    
    func fetchEbookDashboard(withKeyword: String) {
        ACData.DASHBOARDCOORDINATOREBOOKLISTDATA.removeAll()
        ACRequest.POST_DASHBOARD_COORDINATOR_EBOOK_LIST(userId: ACData.LOGINDATA.userID, date: currentDate, yearID: yearID, keyword: withKeyword, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            SVProgressHUD.dismiss()
            ACData.DASHBOARDCOORDINATOREBOOKLISTDATA = results
            self.searchBar.resignFirstResponder()
            self.populateData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    
    func fetchExerciseDashboard(withKeyword: String) {
        ACData.DASHBOARDCOORDINATOREXERCISELISTDATA.removeAll()
        ACRequest.POST_DASHBOARD_COORDINATOR_EXERCISE_LIST(userId: ACData.LOGINDATA.userID, date: currentDate, yearID: yearID, keyword: withKeyword, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            SVProgressHUD.dismiss()
            ACData.DASHBOARDCOORDINATOREXERCISELISTDATA = results
            self.searchBar.resignFirstResponder()
            self.populateData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
