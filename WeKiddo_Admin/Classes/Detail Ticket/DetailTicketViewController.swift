//
//  DetailTicketViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 03/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class DetailTicketViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "View Ticket", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "DetailTicketContentCell", bundle: nil), forCellReuseIdentifier: "detailTicketContentCellID")
    }
}

extension DetailTicketViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 809
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "detailTicketContentCellID", for: indexPath) as? DetailTicketContentCell)!
        cell.detailObj = ACData.DETAILTICKETDATA
        cell.delegate = self
        return cell
    }
}

extension DetailTicketViewController: DetailTicketContentCellDelegate {
    func refreshTable() {
        fetchDetail()
    }
    func fetchDetail() {
        ACRequest.POST_TICKET_DETAIL(userId: ACData.LOGINDATA.userID, ticketID: ACData.DETAILTICKETDATA.ticket_id, schoolID: ACData.DASHBOARDDATA.home_profile_school_id, yearID: ACData.DASHBOARDDATA.home_profile_year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
            ACData.DETAILTICKETDATA = result
            SVProgressHUD.dismiss()
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.none)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
