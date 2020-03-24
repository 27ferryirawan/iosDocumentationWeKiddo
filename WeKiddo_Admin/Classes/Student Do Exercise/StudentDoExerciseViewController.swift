//
//  StudentDoExerciseViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

class StudentDoExerciseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Student Doing Exercise", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Student Doing Exercise", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "StudentDoExerciseContentCell", bundle: nil), forCellReuseIdentifier: "studentDoExerciseContentCellID")
        tableView.register(UINib(nibName: "StudentDoExerciseHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "StudentDoExerciseHeaderView")
    }

}
extension StudentDoExerciseViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "StudentDoExerciseHeaderView") as! StudentDoExerciseHeaderView
        headerView.dateLabel.text = convertDate(time: ACData.COORDINATORSTUDENTDOEXERCISELISTDATA.date)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 33
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.COORDINATORSTUDENTDOEXERCISELISTDATA.student_list.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "studentDoExerciseContentCellID", for: indexPath) as? StudentDoExerciseContentCell)!
        cell.detailObj = ACData.COORDINATORSTUDENTDOEXERCISELISTDATA.student_list[indexPath.row]
        if indexPath.row % 2 == 0 {
            cell.bgView.backgroundColor = .groupTableViewBackground
        } else {
            cell.bgView.backgroundColor = .white
        }
        return cell
    }
}

extension StudentDoExerciseViewController {
    func convertDate(time: String) -> String {
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
        dateFormatterResult.dateFormat = "dd/MM/yyyy"
        let stringDate = dateFormatterResult.string(from: date)
        return stringDate
    }
}
