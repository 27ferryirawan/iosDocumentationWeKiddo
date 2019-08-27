//
//  AdminEventListViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 17/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class AdminEventListViewController: UIViewController {

    @IBOutlet weak var addEventButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        fetchData()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Event Monitoring", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Event Monitoring", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func fetchData() {
        ACData.ADMINEVENTLISTDATA.removeAll()
        ACRequest.POST_ADMIN_GET_MORE_EVENT(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            ACData.ADMINEVENTLISTDATA = jsonDatas
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "HomeEventCell", bundle: nil), forCellReuseIdentifier: "homeEventCellID")
        tableView.register(UINib(nibName: "HomeEventSectionCell", bundle: nil), forCellReuseIdentifier: "homeEventSectionCellID")
        addEventButton.addTarget(self, action: #selector(addEvent), for: .touchUpInside)
    }
    @objc func addEvent() {
        ACRequest.GET_ANNOUNCEMENT_LEVEL_DATA(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, accessToken: ACData.LOGINDATA.accessToken, successCompletion: { (levelDatas) in
            SVProgressHUD.dismiss()
            ACData.ANNOUNCEMENTLEVELLISTDATA = levelDatas
            let addVc = EditEventMonitoringViewController()
            addVc.isEdit = false
            self.navigationController?.pushViewController(addVc, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension AdminEventListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + ACData.ADMINEVENTLISTDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 33 : 77
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventSectionCellID", for: indexPath) as? HomeEventSectionCell)!
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventCellID", for: indexPath) as? HomeEventCell)!
            cell.listObj = ACData.ADMINEVENTLISTDATA[indexPath.row - 1]
            cell.delegate = self
            return cell
        }
    }
}

extension AdminEventListViewController: HomeEventCellDelegate {
    func toDetailEvent() {
        let detailVC = NotificationDetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
