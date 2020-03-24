//
//  ExerciseListViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

class ExerciseListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var schoolID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Exercise", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Exercise", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "ExerciseListHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ExerciseListHeaderView")
        tableView.register(UINib(nibName: "ExerciseListContentCell", bundle: nil), forCellReuseIdentifier: "exerciseListContentCellID")
    }

}
extension ExerciseListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ACData.COORDINATOREXERCISESCHOOLCREATEDATA.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExerciseListHeaderView") as! ExerciseListHeaderView
        headerView.detailObj = ACData.COORDINATOREXERCISESCHOOLCREATEDATA[section]
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 33
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.COORDINATOREXERCISESCHOOLCREATEDATA[section].exercise.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "exerciseListContentCellID", for: indexPath) as? ExerciseListContentCell)!
        cell.delegate = self
        cell.schoolID = self.schoolID
        cell.detailObj = ACData.COORDINATOREXERCISESCHOOLCREATEDATA[indexPath.section].exercise[indexPath.row]
        if indexPath.row % 2 == 0 {
            cell.bgView.backgroundColor = .groupTableViewBackground
        } else {
            cell.bgView.backgroundColor = .white
        }
        return cell
    }
}

extension ExerciseListViewController: ExerciseListContentCellDelegate {
    func toDetailExercise() {
        let exerciseScoreVC = StudentExerciseScoreViewController()
        self.navigationController?.pushViewController(exerciseScoreVC, animated: true)
    }
}
