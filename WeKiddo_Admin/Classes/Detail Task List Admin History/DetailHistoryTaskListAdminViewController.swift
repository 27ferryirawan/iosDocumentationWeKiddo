//
//  DetailHistoryTaskListAdminViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 02/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class DetailHistoryTaskListAdminViewController: UIViewController {

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
        backStyleNavigationController(pageTitle: "Task List View", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "DetailTaskAdminHistoryCell", bundle: nil), forCellReuseIdentifier: "detailTaskAdminHistoryCellID")
        tableView.register(UINib(nibName: "DetailTaskAdminGroupCell", bundle: nil), forCellReuseIdentifier: "detailTaskAdminGroupCellID")
    }
}

extension DetailHistoryTaskListAdminViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + ACData.DETAILTASKADMINDATA.assigne_admin.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 119
        } else {
            return 155
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "detailTaskAdminHistoryCellID", for: indexPath) as? DetailTaskAdminHistoryCell)!
            cell.detailObj = ACData.DETAILTASKADMINDATA
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "detailTaskAdminGroupCellID", for: indexPath) as? DetailTaskAdminGroupCell)!
            cell.currentIndex = indexPath.row - 1
            cell.detailObj = ACData.DETAILTASKADMINDATA.assigne_admin[indexPath.row-1]
            return cell
        }
    }
}
