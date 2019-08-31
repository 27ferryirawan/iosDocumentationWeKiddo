//
//  AddExamViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 25/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class AddExamViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.lightGray, shadowRadius: 3.0, shadowOpactiy: 1.0, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    @IBOutlet weak var saveButton: UIButton!
    var classCount = 1
    var classSelectedArray = [String]()
    var examTitle = ""
    var examDesc = ""
    var examTypeID = ""
    var examSubjectID = ""
    var examLevelID = ""
    var examMajorID = ""
    var examTeacherID = ""
    var selectedSessionArray = [ExamSessionSelectedModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        fetchData()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Add Exam Schedule", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func fetchData() {
        classSelectedArray.append("")
        //TODO : Change Value of schoolID and YearID
        ACRequest.POST_GET_EXAM_TEACHER_LIST(
            userID: ACData.LOGINDATA.userID,
            schoolID: ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
            yearID: ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
            tokenAccess: ACData.LOGINDATA.accessToken,
            successCompletion: { (data) in
                ACData.EXAMTEACHERLIST = data
                self.tableView.reloadData()
                 SVProgressHUD.dismiss()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
//        ACRequest.POST_EXAM_TYPE_LIST(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
//            SVProgressHUD.dismiss()
//            ACData.EXAMTYPELISTDATA = jsonDatas
//            self.tableView.reloadData()
//        }) { (message) in
//            SVProgressHUD.dismiss()
//            ACAlert.show(message: message)
//        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "AddExamCell", bundle: nil), forCellReuseIdentifier: "addExamCellID")
        tableView.register(UINib(nibName: "AddExamClassCell", bundle: nil), forCellReuseIdentifier: "addExamClassCellID")
        tableView.register(UINib(nibName: "AddExamAddMoreClassCell", bundle: nil), forCellReuseIdentifier: "addExamAddMoreClassCellID")
        tableView.register(UINib(nibName: "AddExamFooterCell", bundle: nil), forCellReuseIdentifier: "addExamFooterCellID")
        saveButton.addTarget(self, action: #selector(addNewExamAction), for: .touchUpInside)
    }
    @objc func addNewExamAction() {
        var addSessionOn = "["
        var addClassOn = "["
        
        if classSelectedArray.count != 0 {
            var i = 0
            for data in classSelectedArray {
                if i > 0 {
                    addClassOn += ","
                }
                addClassOn += "{"
                addClassOn += "\"class_id\":\"\(data)\""
                addClassOn += "}"
                
                i += 1
            }
        }
        if selectedSessionArray.count != 0 {
            var i = 0
            for data in selectedSessionArray {
                if i > 0 {
                    addSessionOn += ","
                }
                addSessionOn += "{"
                addSessionOn += "\"session_count\":\"\(data.sessionAt)\","
                addSessionOn += "\"week_count\":\"\(data.weekAt)\""
                addSessionOn += "}"
                
                i += 1
            }
        }
        
        addSessionOn += "]"
        addClassOn += "]"
        
        let newAddSessionOn = addSessionOn.replacingOccurrences(of: "\\", with: "")
        let jsonSessionData = newAddSessionOn.data(using: .utf8)!
        let jsonSession = try! JSONSerialization.jsonObject(with: jsonSessionData, options: .allowFragments)
        
        let newAddClassOn = addClassOn.replacingOccurrences(of: "\\", with: "")
        let jsonClassData = newAddClassOn.data(using: .utf8)!
        let jsonClass = try! JSONSerialization.jsonObject(with: jsonClassData, options: .allowFragments)
        
        
        print("schoolId: \(ACData.LOGINDATA.school_id), userId: \(ACData.LOGINDATA.userID), role: \(ACData.LOGINDATA.role), yearId: \(ACData.LOGINDATA.year_id), examID: \(""), examTitle: \(examTitle), examDesc: \(examDesc), examTypeID: \(examTypeID), subjectID: \(examSubjectID), class: \(jsonClass), session: \(jsonSession)")
        
        //TODO : Change value of school_id and year_id
        let parameters: Parameters = [
            "school_id":ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
            "year_id":ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
            "user_id":ACData.LOGINDATA.userID,
            "school_user_id":examTeacherID,
            "exam_id":"",
            "exam_title":examTitle,
            "exam_desc":examDesc,
            "exam_type_id":examTypeID,
            "subject_id":examSubjectID,
            "class":jsonClass,
            "sessioncounts":jsonSession
        ]
        
        ACRequest.POST_ADD_NEW_EXAM(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension AddExamViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 + classCount
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 473
        } else if indexPath.row < 1 + classCount {
            return 65
        } else if indexPath.row == 1 + classCount {
            return 44
        } else {
            return 140
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addExamCellID", for: indexPath) as? AddExamCell)!
            cell.teacherObj = ACData.EXAMTEACHERLIST
            cell.delegate = self
            return cell
        } else if indexPath.row < 1 + classCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addExamClassCellID", for: indexPath) as? AddExamClassCell)!
            cell.indexCell = indexPath.row - 1
            if ACData.EXAMCLASSDATA != nil{
                cell.detailObj = ACData.EXAMCLASSDATA
            }
            cell.delegate = self
            return cell
        } else if indexPath.row == 1 + classCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addExamAddMoreClassCellID", for: indexPath) as? AddExamAddMoreClassCell)!
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addExamFooterCellID", for: indexPath) as? AddExamFooterCell)!
            if ACData.EXAMSESSIONDATA != nil {
                cell.detailObj = ACData.EXAMSESSIONDATA
            }
            cell.delegate = self
            return cell
        }
    }
}

extension AddExamViewController: AddExamCellDelegate, AddExamClassCellDelegate, AddExamAddMoreClassCellDelegate, AddExamFooterCellDelegate {
    func sessionArrayCollected(withArray: [ExamSessionSelectedModel]) {
        selectedSessionArray = withArray
    }
    
    func addNewMoreClass() {
        classSelectedArray.append("")
        classCount += 1
        tableView.reloadData()
    }
    
    func classSelectedWithValue(value: String, atIndex: Int) {
        classSelectedArray[atIndex] = value
        print(classSelectedArray)
    }
    
    func titleFilledWithValue(value: String) {
        print(value)
        examTitle = value
    }
    
    func descFilledWithValue(value: String) {
        print(value)
        examDesc = value
    }
    
    func subjectSelectedWithValue(value: String) {
        print(value)
        examSubjectID = value
        shouldFetchClassAndSession()
    }
    
    func typeSelectedWithValue(value: String) {
        print(value)
        examTypeID = value
    }
    
    func levelSelectedWithValue(value: String) {
        print(value)
        examLevelID = value
        
        shouldFetchClassAndSession()
    }
    
    func teacherSelected(with value: String) {
        examTeacherID = value
    }
    
    func majorSelectedWithValue(value: String) {
        print(value)
        tableView.reloadData()
    }
    
    func shouldFetchClassAndSession(){
        //TODO : Change Value of SchoolID and YearID
        if !examLevelID.isEmpty{
            ACRequest.POST_GET_EXAM_GET_CLASS(
                userID: ACData.LOGINDATA.userID,
                schoolID: ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
                yearID: ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
                school_user_id: self.examTeacherID,
                subjectID: self.examSubjectID,
                levelID: self.examLevelID,
                tokenAccess: ACData.LOGINDATA.accessToken,
                successCompletion: { (data) in
                    SVProgressHUD.dismiss()
                    ACData.EXAMCLASSDATA = data
                    
                    let lastScrollOffset = self.tableView.contentOffset
                    let cellCount = self.tableView.numberOfRows(inSection: 0)
                    var indexPaths = [IndexPath]()
                    for i in 1...cellCount - 2{
                        indexPaths.append(IndexPath(row: i, section: 0))
                    }
                    self.tableView.reloadRows(at: indexPaths, with: .none)
                    DispatchQueue.main.async {
                        self.view.layoutIfNeeded()
                        self.tableView.setContentOffset(lastScrollOffset, animated: false)
                    }
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        }
        
        //TODO : Change Value of SchoolID and YearID
        ACRequest.POST_GET_EXAM_GET_WEEK(
            userID: ACData.LOGINDATA.userID,
            schoolID: ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
            yearID: ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
            school_user_id: self.examTeacherID,
            subjectID: self.examSubjectID,
            tokenAccess: ACData.LOGINDATA.accessToken,
            successCompletion: { (data) in
                SVProgressHUD.dismiss()
                ACData.EXAMSESSIONDATA = data
                
                let lastScrollOffset = self.tableView.contentOffset
                let cellCount = self.tableView.numberOfRows(inSection: 0)
                self.tableView.reloadRows(at: [IndexPath(item: cellCount - 1, section: 0)], with: .none)
                DispatchQueue.main.async {
                    self.view.layoutIfNeeded()
                    self.tableView.setContentOffset(lastScrollOffset, animated: false)
                }
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

