//
//  AddNewAssignmentViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 05/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class AddNewAssignmentViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var classCount = 1
    var subjectID = ""
    var chapterID = ""
    var teacherID = ""
    var assignmentType = 1
    var assignmentID = ""
    var note = ""
    var isFromEdit = Bool()
    var teacherListCount = 0
    var selectedClassObject = [ClassModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        fetchData()
        if isFromEdit {
            classCount = ACData.ASSIGNMENTDETAILEDITDATA.school_class_list.count
            for item in ACData.ASSIGNMENTDETAILEDITDATA.school_class_list {
                selectedClassObject.append(ClassModel(schoolClass: item.school_class, dueDate: item.due_date))
            }
        } else {
            classCount = 1
            selectedClassObject.append(ClassModel(schoolClass: "0", dueDate: "0"))
        }
    }
    func fetchData(){
        fetchTeacherList()
    }
    func fetchTeacherList(){
        //TODO: Change Value for school ID and yearID
        ACRequest.POST_ASSIGNMENT_GET_TEACHER(userId: ACData.LOGINDATA.userID, schoolId: ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "", yearId: ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (teacherList) in
            ACData.ASSIGNMENTTEACHERLIST = teacherList
            self.teacherListCount = teacherList.assignmentTeacherList.count
            self.teacherID = teacherList.assignmentTeacherList.first?.teacher_id ?? ""
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func configNavigation() {
        detectAdaptiveClass()
        if isFromEdit {
            backStyleNavigationController(pageTitle: "Edit Assignment", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        } else {
            backStyleNavigationController(pageTitle: "Add New Assignment", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "AddAssignmentTopCell", bundle: nil), forCellReuseIdentifier: "addAssignmentTopCellID")
        tableView.register(UINib(nibName: "AddAssignmentClassCell", bundle: nil), forCellReuseIdentifier: "addAssignmentClassCellID")
        tableView.register(UINib(nibName: "AddAssignmentFooterCell", bundle: nil), forCellReuseIdentifier: "addAssignmentFooterCellID")
    }
}

extension AddNewAssignmentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + classCount
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 467
        } else if indexPath.row <= classCount {
            return 140
        } else {
            return 140
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addAssignmentTopCellID", for: indexPath) as? AddAssignmentTopCell)!
            cell.isFromEdit = self.isFromEdit
            cell.teacherObj = ACData.ASSIGNMENTTEACHERLIST
            if isFromEdit {
                cell.detailSubjectEdit = ACData.ASSIGNMENTDETAILEDITDATA
            }
            cell.delegate = self
            return cell
        } else if indexPath.row <= classCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addAssignmentClassCellID", for: indexPath) as? AddAssignmentClassCell)!
            cell.indexArray = indexPath.row
            cell.array = selectedClassObject
            if isFromEdit {
                cell.editObj = ACData.ASSIGNMENTDETAILEDITDATA
            } else {
                if ACData.ASSIGNMENTSUBJECTLIST != nil {
                    cell.obj = ACData.ASSIGNMENTSUBJECTLIST
                } else {
                    // do nothing
                }
            }
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addAssignmentFooterCellID", for: indexPath) as? AddAssignmentFooterCell)!
            cell.delegate = self
            return cell
        }
    }
}

extension AddNewAssignmentViewController: AddAssignmentFooterCellDelegate, AddAssignmentTopCellDelegate, AddAssignmentClassCellDelegate {
    func subjectSelected(withValue: String) {
        print("subject: \(withValue)")
        subjectID = withValue
        let items = tableView.numberOfRows(inSection: 0)
        var indexPaths = [IndexPath]()
        for i in 1...items - 1 {
            indexPaths.append(IndexPath(row: i, section: 0))
        }
        self.tableView.reloadRows(at: indexPaths, with: .none)
    }
    func chapterSelected(withValue: String) {
        print("chapter: \(withValue)")
        chapterID = withValue
    }
    func teacherSelected(withValue: String) {
        print("teacher: \(withValue)")
        teacherID = withValue
    }
    func assignmentSelected(withValue: Int) {
        print("assignmentType: \(withValue)")
        assignmentType = withValue
    }
    func noteFilled(withValue: String) {
        print("notes: \(withValue)")
        note = withValue
    }
    func addMoreClass(counter: Int) {
        if isFromEdit {
            if classCount < ACData.ASSIGNMENTDETAILEDITDATA.schoolClass.count {
                classCount += counter
                selectedClassObject.append(ClassModel(schoolClass: "1", dueDate: "1"))
                tableView.reloadData()
            } else {
                ACAlert.show(message: "Can not add more class")
            }
        } else {
            if classCount < ACData.ASSIGNMENTSUBJECTLIST.classList.count {
                classCount += counter
                selectedClassObject.append(ClassModel(schoolClass: "1", dueDate: "1"))
                tableView.reloadData()
            } else {
                ACAlert.show(message: "Can not add more class")
            }
        }
    }
    func reloadAtIndex() {
        self.tableView.reloadRows(at: [IndexPath(row: classCount, section: 0)], with: UITableView.RowAnimation.none)
    }
    func saveAssignment() {
        for index in selectedClassObject {
            print(index.due_date)
        }
        var addOn = "["
        var i = 0
        for data in selectedClassObject {
            if i > 0 {
                addOn += ","
            }
            addOn += "{"
            addOn += "\"school_class_id\":\"\(data.school_class_id)\","
            addOn += "\"due_date\":\"\(data.due_date)\""
            addOn += "}"
            
            i += 1
        }
        addOn += "]"
        
        let newaddOn = addOn.replacingOccurrences(of: "\\", with: "")
        let jsonData = newaddOn.data(using: .utf8)!
        let jsonO = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
        let parameters: Parameters = [
            "user_id":ACData.LOGINDATA.userID,
            "school_user_id":teacherID,
            "school_id":ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
            "year_id":ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
            "subject_id":isFromEdit ? ACData.ASSIGNMENTDETAILEDITDATA.subject_id : subjectID,
            "chapter_id":isFromEdit ? ACData.ASSIGNMENTDETAILEDITDATA.chapter_id : chapterID,
            "assignment_type":isFromEdit ? ACData.ASSIGNMENTDETAILEDITDATA.assignment_type : assignmentType,
            "assignment_id":isFromEdit ? ACData.ASSIGNMENTDETAILEDITDATA.assignment_id : assignmentID,
            "note":note,
            "school_class":jsonO
        ]
        print("parameter: \(parameters)")
        ACRequest.POST_ADD_NEW_ASSIGNMENT(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func classSelected(atIndex: Int, value: String) {
        selectedClassObject[atIndex-1].school_class_id = value
        //        for index in selectedClassObject {
        //            if index.school_class_id == value {
        //                ACAlert.show(message: "Can not choose same class")
        //            } else {
        //                 selectedClassObject[atIndex-1].school_class_id = value
        //            }
        //        }
    }
    func dateSelected(atIndex: Int, value: String) {
        selectedClassObject[atIndex-1].due_date = value
    }
}
