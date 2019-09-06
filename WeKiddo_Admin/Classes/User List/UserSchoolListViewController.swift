//
//  UserSchoolListViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 06/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class UserSchoolListViewController: UIViewController {

    @IBOutlet weak var addUserButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "User School", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "UserSchoolListCell", bundle: nil), forCellReuseIdentifier: "userSchoolListCellID")
        addUserButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
    }
    @objc func addAction() {
        ACRequest.POST_USER_SCHOOL_ADDPARAM(userId: ACData.LOGINDATA.userID, schoolID: ACData.DASHBOARDDATA.home_profile_school_id, yearID: ACData.DASHBOARDDATA.home_profile_year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
            ACData.USERLISTPARAMDATA = result
            SVProgressHUD.dismiss()
            let addVC = AddUserListViewController()
            self.navigationController?.pushViewController(addVC, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension UserSchoolListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "userSchoolListCellID", for: indexPath) as? UserSchoolListCell)!
        cell.detailObj = ACData.USERLISTDATA[indexPath.row]
        return cell
    }
}
