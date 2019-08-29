//
//  SchoolMonitoringViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 29/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SchoolMonitoringViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "School Monitoring", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "SchoolMonitoringHeaderCell", bundle: nil), forCellReuseIdentifier: "schoolMonitoringHeaderCellID")
    }
}

extension SchoolMonitoringViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 692
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "schoolMonitoringHeaderCellID", for: indexPath) as? SchoolMonitoringHeaderCell)!
        return cell
    }
}
