//
//  EditPaymentViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 28/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class EditPaymentViewController: UIViewController {

    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgView: UIView!
    var selectedStudentPaidArray = [StudentSetPaidModel]()
    var studentArray = 0
    var selectedStudent = [StudentSearchSelected]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Event Monitoring", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "EditPaymentStudentCell", bundle: nil), forCellReuseIdentifier: "editPaymentStudentCellID")
        tableView.register(UINib(nibName: "EditPaymentFooterCell", bundle: nil), forCellReuseIdentifier: "editPaymentFooterCellID")
        buttonSearch.addTarget(self, action: #selector(toStudentSearch), for: .touchUpInside)
    }
    @objc func toStudentSearch() {
        let searchVC = AddDetentionStudentSearchViewController()
        searchVC.studentList = selectedStudent
        searchVC.isFromAnnouncement = false
        searchVC.isFromExamRemedy = false
        searchVC.isFromEventPayment = true
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(selectedStudent) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "studentSelected")
        }
        searchVC.delegate = self
        let navVC = UINavigationController(rootViewController: searchVC)
        self.navigationController?.present(navVC, animated: true, completion: nil)
    }
}

extension EditPaymentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + selectedStudent.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < selectedStudent.count {
            return 88
        } else {
            return 44
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < selectedStudent.count {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "editPaymentStudentCellID", for: indexPath) as? EditPaymentStudentCell)!
            if selectedStudentPaidArray.contains(where: {$0.child_id == selectedStudentPaidArray[indexPath.row].child_id && $0.date == selectedStudentPaidArray[indexPath.row].date}) {
                cell.paidStatusIcon.image = UIImage(named: "radio-on-button")
            } else {
                cell.paidStatusIcon.image = UIImage(named: "circumference")
            }
            cell.studentObj = selectedStudent[indexPath.row]
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "editPaymentFooterCellID", for: indexPath) as? EditPaymentFooterCell)!
            cell.delegate = self
            return cell
        }
    }
}

extension EditPaymentViewController: AddDetentionStudentSearchViewControllerDelegate, EditPaymentStudentCellDelegate, EditPaymentFooterCellDelegate {
    func savePayment() {
        for item in selectedStudentPaidArray {
            print(item.child_id)
        }
        
        var studentOn = "["
        
        if selectedStudentPaidArray.count != 0 {
            var i = 0
            for data in selectedStudentPaidArray {
                if i > 0 {
                    studentOn += ","
                }
                studentOn += "{"
                studentOn += "\"child_id\":\"\(data.child_id)\","
                studentOn += "\"payment_date\":\"\(data.date)\""
                studentOn += "}"
                
                i += 1
            }
        }

        studentOn += "]"
        
        let newAddStudentOn = studentOn.replacingOccurrences(of: "\\", with: "")
        let jsonStudentData = newAddStudentOn.data(using: .utf8)!
        let jsonStudent = try! JSONSerialization.jsonObject(with: jsonStudentData, options: .allowFragments)
        
        let parameters: Parameters = [
            "school_id":ACData.LOGINDATA.school_id,
            "year_id":ACData.LOGINDATA.year_id,
            "user_id":ACData.LOGINDATA.userID,
            "role":ACData.LOGINDATA.role,
            "event_id":ACData.APPROVALDETAILDATA.event_id,
            "student_list":jsonStudent
        ]
        
        ACRequest.POST_SAVE_EVENT_PAYMENT_STUDENT(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func studentArrayCollected(value: [StudentSetPaidModel]) {
        selectedStudentPaidArray = value
        tableView.reloadData()
    }
    func sendSelectedStudent(withStudentArray: [StudentSearchSelected]) {
        for index in withStudentArray {
            print(index.child_id)
        }
        selectedStudent = withStudentArray
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(selectedStudent) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "studentSelected")
        }
        tableView.reloadData()
    }
    func refreshExamRemedyTableWithIndex(index: String) {
        
    }
}
