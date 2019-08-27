//
//  UniversityDetailViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 23/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class UniversityDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
//    var titleHeader = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "")
    }
    func configTable() {
        tableView.register(UINib(nibName: "UniversityDetailCell", bundle: nil), forCellReuseIdentifier: "universityDetailCell")
        tableView.register(UINib(nibName: "UniversityDetailRepresentativeCell", bundle: nil), forCellReuseIdentifier: "universityDetailRepresentativeCell")
        tableView.register(UINib(nibName: "UniversityDetailFooterCell", bundle: nil
        ), forCellReuseIdentifier: "universityDetailFooterCell")
    }
}

extension UniversityDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + ACData.UNIVERSITYDETAILDATA.university_details.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 1570
        } else if indexPath.row == 1 + ACData.UNIVERSITYDETAILDATA.university_details.count {
            return 552
        } else {
            return 110
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "universityDetailCell", for: indexPath) as? UniversityDetailCell)!
            return cell
        } else if indexPath.row == 1 + ACData.UNIVERSITYDETAILDATA.university_details.count {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "universityDetailFooterCell", for: indexPath) as? UniversityDetailFooterCell)!
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "universityDetailRepresentativeCell", for: indexPath) as? UniversityDetailRepresentativeCell)!
            return cell
        }
    }
}
