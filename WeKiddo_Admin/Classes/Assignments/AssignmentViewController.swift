//
//  AssignmentViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 20/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class AssignmentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNewButton: UIButton!
    var assignmentListCount = 0
    var teacherListCount = 0
    var teacherID = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        fetchData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        ACData.ASSIGNMENTLIST.assignmentPickerClass.removeAll()
//        ACData.ASSIGNMENTLIST.assignmentPickerSubject.removeAll()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Assignments", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Assignments", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func fetchData(){
        fetchTeacher()
    }
    func fetchTeacher() {
        //TODO: Change value for school ID and yearID
        ACRequest.POST_ASSIGNMENT_TEACHER_LIST(userId: ACData.LOGINDATA.userID, schoolId: ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "", yearId: ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (teacherList) in
            ACData.ASSIGNMENTTEACHERLISTALL = teacherList
            self.teacherListCount = teacherList.assignmentTeacherList.count
            self.teacherID = teacherList.assignmentTeacherList.first?.teacher_id ?? ""
            self.fetchAssignment()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func fetchAssignment() {
        //TODO: Change value for school ID and yearID
        ACRequest.POST_ASSIGNMENT_LIST(userId: ACData.LOGINDATA.userID, schoolId: ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "", yearId: ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "", school_user_id: self.teacherID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (assignmentDatas) in
            ACData.ASSIGNMENTLIST = assignmentDatas
            self.assignmentListCount = ACData.ASSIGNMENTLIST.assignmentList.count
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "AssignmentSectionCell", bundle: nil), forCellReuseIdentifier: "assignmentSectionCell")
        tableView.register(UINib(nibName: "AssignmentSubjectCell", bundle: nil), forCellReuseIdentifier: "assignmentSubjectCell")
        tableView.dataSource = self
        tableView.delegate = self
        addNewButton.addTarget(self, action: #selector(addNewAction), for: .touchUpInside)
    }
    @objc func addNewAction() {
        let addNewVC = AddNewAssignmentViewController()
        addNewVC.isFromEdit = false
        self.navigationController?.pushViewController(addNewVC, animated: true)
    }
    
//    func fetchSubjectList() {
//        ACRequest.POST_SUBJECT_LIST(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (subjectDatas) in
//            ACData.SUBJECTDATA = subjectDatas
//            SVProgressHUD.dismiss()
//
//        }) { (message) in
//            SVProgressHUD.dismiss()
//        }
//    }
    
}

extension AssignmentViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if teacherID.isEmpty {
            return 0
        }else if teacherID == "ALL"{
            return ACData.ASSIGNMENTLIST.assignmentList.count + 1
        }
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        return 1 + ACData.ASSIGNMENTLIST.assignmentList[section-1].assignment.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 66
        }
        else{
            return 66
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "assignmentSectionCell", for: indexPath) as? AssignmentSectionCell)!
            cell.object = ACData.ASSIGNMENTTEACHERLISTALL
            cell.delegate = self
            return cell
        } else {
            if indexPath.row == 0{
                return UITableViewCell()
            }
            let cell = (tableView.dequeueReusableCell(withIdentifier: "assignmentSubjectCell", for: indexPath) as? AssignmentSubjectCell)!
            cell.delegate = self
            cell.assignmentObjc = ACData.ASSIGNMENTLIST.assignmentList[indexPath.section-1].assignment[indexPath.row-1]
            return cell
        }
    }
}

extension AssignmentViewController: AssignmentListCellDelegate, AssignmentSectionCellDelegate {
    func goToDetail() {
        let assignmentDetailVC = AssignmentDetailViewController()
        self.navigationController?.pushViewController(assignmentDetailVC, animated: true)
    }
    func reloadTable() {
        self.assignmentListCount = ACData.ASSIGNMENTLIST.assignmentList.count
        self.tableView.reloadData()
    }
    func teacherSelected(with teacherID: String) {
        self.teacherID = teacherID
        self.fetchAssignment()
    }
}
