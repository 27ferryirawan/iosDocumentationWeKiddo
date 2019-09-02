//
//  AddNewTaskAdminViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 01/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AddNewTaskAdminViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.lightGray, shadowRadius: 3.0, shadowOpactiy: 1.0, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Add Task", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "AddNewTaskAdminHeaderCell", bundle: nil), forCellReuseIdentifier: "addNewTaskAdminHeaderCellID")
        tableView.register(UINib(nibName: "AddNewTaskAdminAssigneeCell", bundle: nil), forCellReuseIdentifier: "addNewTaskAdminAssigneeCellID")
        tableView.register(UINib(nibName: "AddNewTaskAdminSubmitButtonCell", bundle: nil), forCellReuseIdentifier: "addNewTaskAdminSubmitButtonCellID")
    }
}

extension AddNewTaskAdminViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + ACData.ADMINLISTDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 179
        } else if indexPath.row <= ACData.ADMINLISTDATA.count {
            return 167
        } else {
            return 44
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addNewTaskAdminHeaderCellID", for: indexPath) as? AddNewTaskAdminHeaderCell)!
            cell.delegate = self
            return cell
        } else if indexPath.row <= ACData.ADMINLISTDATA.count {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addNewTaskAdminAssigneeCellID", for: indexPath) as? AddNewTaskAdminAssigneeCell)!
            cell.indexCurrent = indexPath.row - 1
            cell.detailObj = ACData.ADMINLISTDATA[indexPath.row - 1]
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "addNewTaskAdminSubmitButtonCellID", for: indexPath) as? AddNewTaskAdminSubmitButtonCell)!
            return cell
        }
    }
}

extension AddNewTaskAdminViewController: AddNewTaskAdminHeaderCellDelegate {
    func dateFilled(withDate: String) {
        print("Selected Date: \(withDate)")
    }
    
    func descFilled(withDesc: String) {
        print("Description: \(withDesc)")
    }
}
