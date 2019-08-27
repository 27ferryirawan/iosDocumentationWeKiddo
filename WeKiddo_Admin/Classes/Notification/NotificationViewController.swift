//
//  NotificationViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class NotificationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let sectionNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        fetchData()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Notification", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Notification", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "NotificationSectionCell", bundle: nil), forCellReuseIdentifier: "notificationSectionCell")
        tableView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "notificationCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    func fetchData() {
        ACData.NOTIFICATIONDATA.removeAll()
        ACRequest.GET_NOTIFICATION_DATA(parentID: "P1", successCompletion: { (notificationModelData) in
            ACData.NOTIFICATIONDATA = notificationModelData
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNumber
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionNumber + ACData.NOTIFICATIONDATA.count
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // TODO: handle delete (by removing the data from your array and updating the tableview)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 32
        } else {
            return 55
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "notificationSectionCell", for: indexPath) as? NotificationSectionCell)!
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as? NotificationCell)!
            return cell
        }
    }
}
