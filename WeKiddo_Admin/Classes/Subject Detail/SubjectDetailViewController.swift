//
//  SubjectDetailViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 11/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SubjectDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Subject Detail", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "SubjectDetailHeaderCell", bundle: nil), forCellReuseIdentifier: "subjectDetailHeaderCellID")
        tableView.register(UINib(nibName: "SubjectDetailSectionCell", bundle: nil), forCellReuseIdentifier: "subjectDetailSectionCellID")
        tableView.register(UINib(nibName: "SubjectDetailUpcommingSessionCell", bundle: nil), forCellReuseIdentifier: "subjectDetailUpcommingSessionCellID")
        tableView.register(UINib(nibName: "SubjectDetailUpcommingAssignmentCell", bundle: nil), forCellReuseIdentifier: "subjectDetailUpcommingAssignmentCellID")
        tableView.register(UINib(nibName: "SubjectDetailQuestionCell", bundle: nil), forCellReuseIdentifier: "subjectDetailQuestionCellID")
        tableView.register(UINib(nibName: "SubjectDetailButtonSectionCell", bundle: nil), forCellReuseIdentifier: "subjectDetailButtonSectionCellID")
        tableView.register(UINib(nibName: "SubjectDetailPerformanceCell", bundle: nil), forCellReuseIdentifier: "subjectDetailPerformanceCellID")
    }
}

extension SubjectDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6 + ACData.SUBJECTDETAILDATA.upcoming_sessions.count + ACData.SUBJECTDETAILDATA.upcoming_assignments.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 155
        } else if indexPath.row == 1 {
            return 33
        } else if indexPath.row > 1 && indexPath.row < ACData.SUBJECTDETAILDATA.upcoming_sessions.count + 2 {
            return 88
        } else if indexPath.row == ACData.SUBJECTDETAILDATA.upcoming_sessions.count + 2 {
            return 65
        } else if indexPath.row == ACData.SUBJECTDETAILDATA.upcoming_sessions.count + 3 {
            return 33
        } else if indexPath.row > ACData.SUBJECTDETAILDATA.upcoming_sessions.count + 3 && indexPath.row < ACData.SUBJECTDETAILDATA.upcoming_sessions.count + ACData.SUBJECTDETAILDATA.upcoming_assignments.count + 4 {
            return 66
        } else if indexPath.row == ACData.SUBJECTDETAILDATA.upcoming_sessions.count + ACData.SUBJECTDETAILDATA.upcoming_assignments.count + 4 {
            return 65
        } else {
            return 463
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectDetailHeaderCellID", for: indexPath) as? SubjectDetailHeaderCell)!
            cell.detailObj = ACData.SUBJECTDETAILDATA
            cell.delegate = self
            return cell
        } else if indexPath.row == 1 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectDetailSectionCellID", for: indexPath) as? SubjectDetailSectionCell)!
            cell.config(isAssignment: false)
            return cell
        } else if indexPath.row > 1 && indexPath.row < ACData.SUBJECTDETAILDATA.upcoming_sessions.count + 2 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectDetailUpcommingSessionCellID", for: indexPath) as? SubjectDetailUpcommingSessionCell)!
            cell.detailObj = ACData.SUBJECTDETAILDATA.upcoming_sessions[indexPath.row - 2]
            return cell
        } else if indexPath.row == ACData.SUBJECTDETAILDATA.upcoming_sessions.count + 2 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectDetailButtonSectionCellID", for: indexPath) as? SubjectDetailButtonSectionCell)!
            if ACData.SUBJECTDETAILDATA.upcoming_sessions.count == 0 {
                cell.buttonSection.isHidden = true
            } else {
                cell.buttonSection.isHidden = false
            }
            cell.config(isAssignment: false)
            return cell
        } else if indexPath.row == ACData.SUBJECTDETAILDATA.upcoming_sessions.count + 3 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectDetailSectionCellID", for: indexPath) as? SubjectDetailSectionCell)!
            cell.config(isAssignment: true)
            return cell
        } else if indexPath.row > ACData.SUBJECTDETAILDATA.upcoming_sessions.count + 3 && indexPath.row < ACData.SUBJECTDETAILDATA.upcoming_sessions.count + ACData.SUBJECTDETAILDATA.upcoming_assignments.count + 4 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectDetailUpcommingAssignmentCellID", for: indexPath) as? SubjectDetailUpcommingAssignmentCell)!
            if ACData.SUBJECTDETAILDATA.upcoming_assignments.count != 0 {
                cell.assignmentObjc = ACData.SUBJECTDETAILDATA.upcoming_assignments[indexPath.row - ACData.SUBJECTDETAILDATA.upcoming_sessions.count + 4]
            } else {
                // do nothing with the cell
            }
            return cell
        } else if indexPath.row == ACData.SUBJECTDETAILDATA.upcoming_sessions.count + ACData.SUBJECTDETAILDATA.upcoming_assignments.count + 4 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectDetailButtonSectionCellID", for: indexPath) as? SubjectDetailButtonSectionCell)!
            if ACData.SUBJECTDETAILDATA.upcoming_assignments.count == 0 {
                cell.buttonSection.isHidden = true
            } else {
                cell.buttonSection.isHidden = false
            }
            cell.config(isAssignment: true)
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectDetailPerformanceCellID", for: indexPath) as? SubjectDetailPerformanceCell)!
            cell.dataObj = ACData.SUBJECTDETAILDATA
            return cell
        }
    }
}

extension SubjectDetailViewController: SubjectDetailHeaderCellDelegate {
    func toSearchPage() {
        let searchVC = SearchViewController()
        searchVC.subjectId = ACData.SUBJECTDETAILDATA.score_subject_id
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
}
