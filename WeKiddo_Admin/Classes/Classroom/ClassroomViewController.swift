//
//  ClassroomViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 24/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class ClassroomViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Class Room", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Class Room", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "ClassroomHeaderCell", bundle: nil), forCellReuseIdentifier: "classroomHeaderCellID")
        tableView.register(UINib(nibName: "ClassroomContentCell", bundle: nil), forCellReuseIdentifier: "classroomContentCellID")
    }
}

extension ClassroomViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else {
            return "Class \(section)"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 178
        } else {
            return 55
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "classroomHeaderCellID", for: indexPath) as? ClassroomHeaderCell)!
            
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "classroomContentCellID", for: indexPath) as? ClassroomContentCell)!
            
            return cell
        }
    }
}
