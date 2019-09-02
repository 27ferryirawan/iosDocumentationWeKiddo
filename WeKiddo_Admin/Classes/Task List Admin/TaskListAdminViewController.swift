//
//  TaskListAdminViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 01/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class TaskListAdminViewController: UIViewController {

    @IBOutlet weak var addNewButton: UIButton!
    @IBOutlet weak var newViewActive: UIView!
    @IBOutlet weak var historyViewActive: UIView!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var isNew = true
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        getNew()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Task List Admin", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Task List Admin", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "TaskListAdminCell", bundle: nil), forCellReuseIdentifier: "taskListAdminCellID")
        newButton.addTarget(self, action: #selector(newClicked), for: .touchUpInside)
        historyButton.addTarget(self, action: #selector(historyClicked), for: .touchUpInside)
        addNewButton.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
    }
    @objc func addNewTask() {
        fetchListAdmin()
    }
    @objc func newClicked() {
        newViewActive.backgroundColor = ACColor.MAIN
        historyViewActive.backgroundColor = .clear
        addNewButton.isHidden = false
        isNew = true
        getNew()
    }
    @objc func historyClicked() {
        newViewActive.backgroundColor = .clear
        historyViewActive.backgroundColor = ACColor.MAIN
        isNew = false
        addNewButton.isHidden = true
        getHistory()
    }
    func getNew() {
        ACData.TASKLISTADMINNEWDATA.removeAll()
        ACRequest.POST_TASKLIST_ADMIN_NEW(userId: ACData.LOGINDATA.userID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            ACData.TASKLISTADMINNEWDATA = results
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func getHistory() {
        ACData.TASKLISTADMINHISTORYDATA.removeAll()
        ACRequest.POST_TASKLIST_ADMIN_HISTORY(userId: ACData.LOGINDATA.userID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            ACData.TASKLISTADMINHISTORYDATA = results
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func fetchListAdmin() {
        ACData.ADMINLISTDATA.removeAll()
        ACRequest.POST_ADMIN_LIST(userId: ACData.LOGINDATA.userID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            ACData.ADMINLISTDATA = results
            SVProgressHUD.dismiss()
            let addNewVc = AddNewTaskAdminViewController()
            self.navigationController?.pushViewController(addNewVc, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension TaskListAdminViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isNew ? ACData.TASKLISTADMINNEWDATA.count : ACData.TASKLISTADMINHISTORYDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isNew {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "taskListAdminCellID", for: indexPath) as? TaskListAdminCell)!
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "taskListAdminCellID", for: indexPath) as? TaskListAdminCell)!
            return cell
        }
    }
}
