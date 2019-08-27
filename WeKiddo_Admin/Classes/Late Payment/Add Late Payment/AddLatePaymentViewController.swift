//
//  AddLatePaymentViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AddLatePaymentViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var selectedStudent = [StudentSearchSelected]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Search", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "AddLatePaymentFormCell", bundle: nil), forCellReuseIdentifier: "addLatePaymentFormCellID")
        tableView.register(UINib(nibName: "AddLatePaymentStudentCell", bundle: nil), forCellReuseIdentifier: "addLatePaymentStudentCellID")
        searchButton.addTarget(self, action: #selector(toSearchStudent), for: .touchUpInside)
    }
    @objc func toSearchStudent() {
        let searchVC = AddDetentionStudentSearchViewController()
        searchVC.studentList = selectedStudent
        searchVC.isFromAnnouncement = false
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

extension AddLatePaymentViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + selectedStudent.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedStudent.count == 0 {
            return 380
        } else {
            if indexPath.row < selectedStudent.count {
                return 70
            } else {
                return 380
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedStudent.count == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addLatePaymentFormCellID", for: indexPath) as? AddLatePaymentFormCell)!
            cell.studentLists = selectedStudent
            return cell
        } else {
            if indexPath.row < selectedStudent.count {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "addLatePaymentStudentCellID", for: indexPath) as? AddLatePaymentStudentCell)!
                cell.studentObj = selectedStudent[indexPath.row]
                cell.delegate = self
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "addLatePaymentFormCellID", for: indexPath) as? AddLatePaymentFormCell)!
                return cell
            }
        }
    }
}

extension AddLatePaymentViewController: AddDetentionStudentSearchViewControllerDelegate, AddLatePaymentStudentCellDelegate {
    func refreshExamRemedyTableWithIndex(index: String) {
    }
    func deleteChildFromArray(atIndex: Int) {
        selectedStudent.remove(at: atIndex)
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
}
