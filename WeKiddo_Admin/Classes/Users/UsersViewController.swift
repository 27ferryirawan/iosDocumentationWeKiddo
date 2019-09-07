//
//  UsersViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 07/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class UsersViewController: UIViewController {

    @IBOutlet weak var addUserButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "User", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "UsersCell", bundle: nil), forCellReuseIdentifier: "usersSearchCellID")
        tableView.register(UINib(nibName: "UsersContentCell", bundle: nil), forCellReuseIdentifier: "usersContentCellID")
        addUserButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
    }
    @objc func addAction() {
        ACRequest.POST_USERS_ADDPARAMS(userId: ACData.LOGINDATA.userID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            ACData.USERDATA = results
            SVProgressHUD.dismiss()
            let addVC = AddUsersViewController()
            self.navigationController?.pushViewController(addVC, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + ACData.USERSLISTSDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 44
        } else {
            return 140
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "usersSearchCellID", for: indexPath) as? UsersCell)!
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "usersContentCellID", for: indexPath) as? UsersContentCell)!
            cell.index = indexPath.row - 1
            cell.detailObj = ACData.USERSLISTSDATA[indexPath.row - 1]
            return cell
        }
    }
}
