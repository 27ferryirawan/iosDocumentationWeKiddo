//
//  AddUserListViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 06/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AddUserListViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Add User", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "AddUserListCell", bundle: nil), forCellReuseIdentifier: "addUserListCellID")
        tableView.register(UINib(nibName: "AddUserSubjectClassCell", bundle: nil), forCellReuseIdentifier: "addUserSubjectClassCellID")
    }
}

extension AddUserListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 805
        } else {
            return 44
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addUserListCellID", for: indexPath) as? AddUserListCell)!
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addUserSubjectClassCellID", for: indexPath) as? AddUserSubjectClassCell)!
            return cell
        }
    }
}
