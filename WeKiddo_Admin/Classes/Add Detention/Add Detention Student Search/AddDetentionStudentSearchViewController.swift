//
//  AddDetentionStudentSearchViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 09/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

protocol AddDetentionStudentSearchViewControllerDelegate: class {
    func sendSelectedStudent(withStudentArray: [StudentSearchSelected])
    func refreshExamRemedyTableWithIndex(index: String)
}

class AddDetentionStudentSearchViewController: UIViewController {

    @IBOutlet weak var addStudentButton: UIButton!{
        didSet{
            addStudentButton.layer.cornerRadius = 5
            addStudentButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var studentResult = 0
    var examRemedyID = ""
    var examSchoolRemedyID = ""
    var isFromAnnouncement = false
    var isFromExamRemedy = false
    var isFromEventPayment = false
    var classID = ""
//    var studentList = [StudentSearchSelected]()
    var studentList = [StudentSearchSelected]()
    weak var delegate: AddDetentionStudentSearchViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        
        let placeData = UserDefaults.standard.data(forKey: "studentSelected")
        let placeArray = try! JSONDecoder().decode([StudentSearchSelected].self, from: placeData!)
        studentList = placeArray
        print("harusnya ada : \(studentList)")
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Add Student", isLeftLogoHide: "", isLeftSecondLogoHide: "")
    }
    func configTable() {
        tableView.register(UINib(nibName: "AddDetentionStudentSearchCell", bundle: nil), forCellReuseIdentifier: "addDetentionStudentSearchCellID")
        tableView.isHidden = true
        addStudentButton.addTarget(self, action: #selector(addToArrayandDismiss), for: .touchUpInside)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.delegate?.sendSelectedStudent(withStudentArray: studentList)
        self.delegate?.refreshExamRemedyTableWithIndex(index: examSchoolRemedyID)
    }
    @objc func addToArrayandDismiss() {
        if isFromExamRemedy {
            var addOn = "["
            var i = 0
            for data in studentList {
                if i > 0 {
                    addOn += ","
                }
                addOn += "{"
                addOn += "\"id\":\"\(data.child_id)\""
                addOn += "}"
                
                i += 1
            }
            addOn += "]"
            
            let newaddOn = addOn.replacingOccurrences(of: "\\", with: "")
            let jsonData = newaddOn.data(using: .utf8)!
            let jsonO = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            let parameters: Parameters = [
                "user_id":ACData.LOGINDATA.userID,
                "role":ACData.LOGINDATA.role,
                "school_id":ACData.LOGINDATA.school_id,
                "year_id":ACData.LOGINDATA.year_id,
                "exam_remedy_id":examRemedyID,
                "childs":jsonO
            ]
            print(parameters)
            ACRequest.POST_ADD_NEW_REMEDY_STUDENT_EXAM(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
                SVProgressHUD.dismiss()
                self.dismiss(animated: true, completion: nil)
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message:message)
            }
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension AddDetentionStudentSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentResult
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "addDetentionStudentSearchCellID", for: indexPath) as? AddDetentionStudentSearchCell)!
        cell.studentObj = ACData.STUDENTSEARCHDATA[indexPath.row]
        cell.studentLists = self.studentList
        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
}

extension AddDetentionStudentSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.count > 2 {
            studentResult = 0
            ACData.STUDENTSEARCHDATA.removeAll()
            if !isFromAnnouncement {
                if isFromEventPayment {
                    ACRequest.POST_SEARCH_STUDENT_LISTS_AT_EVENT(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, eventID: ACData.APPROVALDETAILDATA.event_id, targetID: ACData.APPROVALDETAILDATA.school_class_id, keyword: searchBar.text!, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (resultDatas) in
                        ACData.STUDENTSEARCHDATA = resultDatas
                        self.studentResult = ACData.STUDENTSEARCHDATA.count
                        SVProgressHUD.dismiss()
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                    }) { (message) in
                        SVProgressHUD.dismiss()
                    }
                } else {
                    ACRequest.POST_SEARCH_STUDENT_LISTS(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, keyword: searchBar.text!, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (resultDatas) in
                        ACData.STUDENTSEARCHDATA = resultDatas
                        self.studentResult = ACData.STUDENTSEARCHDATA.count
                        SVProgressHUD.dismiss()
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                    }) { (message) in
                        SVProgressHUD.dismiss()
                    }
                }
            } else {
                ACRequest.POST_ANNOUNCEMENT_SEARCH_STUDENT_LISTS(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, classID: self.classID, keyword: searchBar.text!, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (resultDatas) in
                    ACData.STUDENTSEARCHDATA = resultDatas
                    self.studentResult = ACData.STUDENTSEARCHDATA.count
                    SVProgressHUD.dismiss()
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }) { (message) in
                    SVProgressHUD.dismiss()
                }
            }
        }
        searchBar.resignFirstResponder()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.studentResult = 0
        tableView.isHidden = false
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
}

extension AddDetentionStudentSearchViewController: AddDetentionStudentSearchCellDelegate {
    func refreshData(withIndex: Int, withChildID: String) {
        let obj = ACData.STUDENTSEARCHDATA[withIndex]
        studentList.append(StudentSearchSelected(childID: obj.child_id, childName: obj.child_name, childImage: obj.child_image, childNIS: obj.child_nis, schoolClass: obj.school_class) )
        print("array:\(studentList)")
    }
    func deleteData(withIndex: Int, withChildID: String) {
        for (index, item) in studentList.enumerated() {
            if item.child_id == withChildID {
                studentList.remove(at: index)
            }
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(studentList) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "studentSelected")
        }
        print("array:\(studentList)")
    }
}
