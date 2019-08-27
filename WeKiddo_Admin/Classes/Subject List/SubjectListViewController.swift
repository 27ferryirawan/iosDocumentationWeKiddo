//
//  SubjectListViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 20/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class SubjectListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let candidates = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
    let ratings = [33.0, 20.0, 13.0, 9.0, 8.0, 6.0]
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        fetchData()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Subject List", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Subject List", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "SubjectContentCell", bundle: nil), forCellReuseIdentifier: "subjectContentCell")
        tableView.register(UINib(nibName: "SubjectGraphicPerformanceCell", bundle: nil), forCellReuseIdentifier: "subjectGraphicPerformanceCell")
    }
    func fetchData() {
        ACData.SUBJECTLISTDATA.removeAll()
        ACRequest.GET_SUBJECT_LIST_PERFORMANCE(childID: ACData.HOMEDATA.childID, successCompletion: { (subjectListDatas) in
            ACData.SUBJECTLISTDATA = subjectListDatas
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}

extension SubjectListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + ACData.SUBJECTLISTDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != ACData.SUBJECTLISTDATA.count {
            return 55
        } else {
            return 365
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != ACData.SUBJECTLISTDATA.count {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectContentCell", for: indexPath) as? SubjectContentCell)!
            cell.subjObj = ACData.SUBJECTLISTDATA[indexPath.row]
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectGraphicPerformanceCell", for: indexPath) as? SubjectGraphicPerformanceCell)!
            cell.setChart(dataPoints: candidates, values: ratings)
            return cell
        }
    }
}

extension SubjectListViewController: SubjectContentCellDelegate {
    func toDetail() {
        let subjectDetailVC = SubjectDetailViewController()
        self.navigationController?.pushViewController(subjectDetailVC, animated: true)
    }
}
