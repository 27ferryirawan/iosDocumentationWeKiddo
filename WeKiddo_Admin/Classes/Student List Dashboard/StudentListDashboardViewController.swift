//
//  StudentListDashboardViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

class StudentListDashboardViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var isStudent = Bool()
    var isTeacher = Bool()
    var isParent = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
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

}
extension StudentListDashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isStudent {
            return 210
        } else {
            return 120
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isStudent {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "studentDashboardContentCellID", for: indexPath) as? StudentDashboardContentCell)!
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "teacherDashboardContentCellID", for: indexPath) as? TeacherDashboardContentCell)!
            return cell
        }
    }
}

extension StudentListDashboardViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 3 {
            print(searchText)
        }
    }
}
