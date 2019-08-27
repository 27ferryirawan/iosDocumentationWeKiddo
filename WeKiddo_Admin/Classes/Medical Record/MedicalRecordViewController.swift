//
//  MedicalRecordViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 14/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class MedicalRecordViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Medical Record", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        }
        else{
            backStyleNavigationController(pageTitle: "Medical Record", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "MedicalRecordCell", bundle: nil), forCellReuseIdentifier: "medicalRecordCell")
    }
}

extension MedicalRecordViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.MEDICAL.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 432
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "medicalRecordCell", for: indexPath) as? MedicalRecordCell)!
        cell.medicalObjc = ACData.MEDICAL[indexPath.row]
        return cell
    }
}
