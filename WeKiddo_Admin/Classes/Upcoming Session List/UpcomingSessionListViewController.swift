//
//  UpcomingSessionListViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 16/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class UpcomingSessionListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Upcoming Session", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "UpcomingSessionListCell", bundle: nil), forCellReuseIdentifier: "upcomingSessionListCellID")
    }
}

extension UpcomingSessionListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ACData.UPCOMINGSESSIONLISTDATA.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.UPCOMINGSESSIONLISTDATA[section].session_item.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 25))
        bgView.backgroundColor = .clear
        let dateLabel = UILabel(frame: CGRect(x: 10, y: 0, width: bgView.frame.size.width - 10, height: 25))
        dateLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        dateLabel.textColor = .black
        dateLabel.numberOfLines = 0
        dateLabel.text = ACData.UPCOMINGSESSIONLISTDATA[section].dateForHuman
        bgView.addSubview(dateLabel)
        return bgView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "upcomingSessionListCellID", for: indexPath) as? UpcomingSessionListCell)!
        cell.detailObj = ACData.UPCOMINGSESSIONLISTDATA[indexPath.section].session_item[indexPath.row]
        return cell
    }
}
