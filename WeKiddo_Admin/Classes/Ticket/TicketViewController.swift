//
//  TicketViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 03/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class TicketViewController: UIViewController {

    @IBOutlet weak var addNewButton: UIButton!
    @IBOutlet weak var pendingViewActive: UIView!
    @IBOutlet weak var historyViewActive: UIView!
    @IBOutlet weak var pendingButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var isPending = true
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        getPending()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Ticket", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Ticket", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "TicketCell", bundle: nil), forCellReuseIdentifier: "ticketCellID")
        pendingButton.addTarget(self, action: #selector(pendingClicked), for: .touchUpInside)
        historyButton.addTarget(self, action: #selector(historyClicked), for: .touchUpInside)
        addNewButton.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
    }
    @objc func addNewTask() {
        let addVC = AddTicketViewController()
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    @objc func pendingClicked() {
        pendingViewActive.backgroundColor = ACColor.MAIN
        historyViewActive.backgroundColor = .clear
        addNewButton.isHidden = false
        isPending = true
        getPending()
    }
    @objc func historyClicked() {
        pendingViewActive.backgroundColor = .clear
        historyViewActive.backgroundColor = ACColor.MAIN
        isPending = false
        addNewButton.isHidden = true
        getHistory()
    }
    func getPending() {
        ACData.TICKETPENDINGDATA.removeAll()
        ACRequest.POST_PENDING_TICKET(userId: ACData.LOGINDATA.userID, schoolID: ACData.DASHBOARDDATA.home_profile_school_id, yearID: ACData.DASHBOARDDATA.home_profile_year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            ACData.TICKETPENDINGDATA = results
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func getHistory() {
        ACData.TICKETPENDINGDATA.removeAll()
        ACRequest.POST_HISTORY_TICKET(userId: ACData.LOGINDATA.userID, schoolID: ACData.DASHBOARDDATA.home_profile_school_id, yearID: ACData.DASHBOARDDATA.home_profile_year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
            ACData.TICKETPENDINGDATA = results
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension TicketViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.TICKETPENDINGDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "ticketCellID", for: indexPath) as? TicketCell)!
        cell.detailObj = ACData.TICKETPENDINGDATA[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension TicketViewController: TicketCellDelegate {
    func toTicketDetail() {
        let detailVC = DetailTicketViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

