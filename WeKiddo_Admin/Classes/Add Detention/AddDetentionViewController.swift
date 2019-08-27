//
//  AddDetentionViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 09/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class AddDetentionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var reasonString = ""
    var studentSelected = [StudentSearchSelected]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Add Detention", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "AddDetentionHeaderCell", bundle: nil), forCellReuseIdentifier: "addDetentionHeaderCellID")
        tableView.register(UINib(nibName: "AddDetentionStudentCell", bundle: nil), forCellReuseIdentifier: "addDetentionStudentCellID")
        tableView.register(UINib(nibName: "AddDetentionFooterCell", bundle: nil), forCellReuseIdentifier: "addDetentionFooterCellID")
    }
}

extension AddDetentionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + studentSelected.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 65
        } else if indexPath.row <= studentSelected.count {
            return 77
        } else {
            return 180
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addDetentionHeaderCellID", for: indexPath) as? AddDetentionHeaderCell)!
            cell.delegate = self
            return cell
        } else if indexPath.row <= studentSelected.count {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addDetentionStudentCellID", for: indexPath) as? AddDetentionStudentCell)!
            cell.studentObj = studentSelected[indexPath.row - 1]
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addDetentionFooterCellID", for: indexPath) as? AddDetentionFooterCell)!
            cell.delegate = self
            return cell
        }
    }
}

extension AddDetentionViewController: AddDetentionHeaderCellDelegate, AddDetentionStudentSearchViewControllerDelegate, AddDetentionStudentCellDelegate, AddDetentionFooterCellDelegate {
    func refreshExamRemedyTableWithIndex(index: String) {
    }
    func textViewPlaceHolder(textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }    
    func toSearchStudentPage(withStudentsLists: [StudentSearchSelected]) {
        let searchVC = AddDetentionStudentSearchViewController()
        searchVC.studentList = studentSelected
        searchVC.isFromAnnouncement = false
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(studentSelected) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "studentSelected")
        }
        searchVC.delegate = self
        let navVC = UINavigationController(rootViewController: searchVC)
        self.navigationController?.present(navVC, animated: true, completion: nil)
    }
    func sendSelectedStudent(withStudentArray: [StudentSearchSelected]) {
//        print("hasil jadi: \(withStudentArray)")
        for index in withStudentArray {
            print(index.child_id)
        }
        studentSelected = withStudentArray
        tableView.reloadData()
    }
    func deleteChildFromArray(atIndex: Int) {
        studentSelected.remove(at: atIndex)
        tableView.reloadData()
    }
    func reasonFilled(withReason: String) {
        reasonString = withReason
    }
    func detentionClicked() {
        for index in studentSelected {
            print(index.child_id)
        }
        var addOn = "["
        var i = 0
        for data in studentSelected {
            if i > 0 {
                addOn += ","
            }
            addOn += "{"
            addOn += "\"child_id\":\"\(data.child_id)\""
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
            "reason":reasonString,
            "student_list":jsonO
        ]
        ACRequest.POST_ADD_STUDENT_DETENTION(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
            UserDefaults.standard.removeObject(forKey: "studentSelected")
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
