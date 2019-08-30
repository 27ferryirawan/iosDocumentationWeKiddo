//
//  TaskListViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 30/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Task List", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "TaskListCell", bundle: nil), forCellReuseIdentifier: "taskListCellID")
        let headerNib = UINib.init(nibName: "TaskListHeaderCellView", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "TaskListHeaderCellView")
    }
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ACData.TASKLISTDATA.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.TASKLISTDATA[section].detail.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 33
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TaskListHeaderCellView") as! TaskListHeaderCellView
        headerView.dateView.backgroundColor = ACColor.MAIN
        headerView.dateView.layer.cornerRadius = 5.0
        headerView.dateView.layer.masksToBounds = true
        headerView.dateLabel.text = getMonth(time: ACData.TASKLISTDATA[section].task_date)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "taskListCellID", for: indexPath) as? TaskListCell)!
        cell.indexObject = indexPath.row
        cell.sectionObject = indexPath.section
        cell.detailClassObj = ACData.TASKLISTDATA[indexPath.section].detail[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension TaskListViewController: TaskListCellDelegate {
    func toDetailSpecialAttention(withSection: Int, withIndex: Int) {
        let detailVC = TaskListDetailViewController()
        detailVC.object = ACData.TASKLISTDATA[withSection].detail[withIndex]
        detailVC.fromDashboard = false
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension TaskListViewController {
    func getMonth(time: String) -> String {
        // Convert from string to date first
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: time) else {
            return ""
        }
        // then convert date to string again
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatterResult.locale = NSLocale.current
        dateFormatterResult.dateFormat = "dd MMM yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
