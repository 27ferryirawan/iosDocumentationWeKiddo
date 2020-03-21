//
//  AssignmentListViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 21/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AssignmentListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Assignment", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Assignment", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "AssignmentListHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "AssignmentListHeaderView")
        tableView.register(UINib(nibName: "AssignmentListContentCell", bundle: nil), forCellReuseIdentifier: "assignmentListContentCelliD")
    }

}
extension AssignmentListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AssignmentListHeaderView") as! AssignmentListHeaderView
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "assignmentListContentCelliD", for: indexPath) as? AssignmentListContentCell)!
        cell.delegate = self
        return cell
    }
}

extension AssignmentListViewController: AssignmentListContentCellDelegate {
    func toDetailWorksheet() {
        let worksheetVC = WorksheetSubmissionViewController()
        self.navigationController?.pushViewController(worksheetVC, animated: true)
    }
}
