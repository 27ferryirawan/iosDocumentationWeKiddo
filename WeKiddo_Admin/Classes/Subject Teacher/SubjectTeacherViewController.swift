//
//  SubjectTeacherViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 12/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class SubjectTeacherViewController: UIViewController {

    @IBOutlet weak var classViewActive: UIView!
    @IBOutlet weak var subjectViewActive: UIView!
    @IBOutlet weak var classButton: UIButton!
    @IBOutlet weak var subjectButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var isSubject = true
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        getBySubject()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Subject Teacher", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Subject Teacher", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "SubjectTeacherSectionCell", bundle: nil), forCellReuseIdentifier: "subjectTeacherSectionCellID")
        tableView.register(UINib(nibName: "SubjectTeacherRowCell", bundle: nil), forCellReuseIdentifier: "subjectTeacherRowCellID")
        tableView.register(UINib(nibName: "ClassTeacherRowCell", bundle: nil), forCellReuseIdentifier: "classTeacherRowCellID")
        subjectButton.addTarget(self, action: #selector(subjectClicked), for: .touchUpInside)
        classButton.addTarget(self, action: #selector(classClicked), for: .touchUpInside)
    }
    @objc func subjectClicked() {
        subjectViewActive.backgroundColor = ACColor.MAIN
        classViewActive.backgroundColor = .clear
        isSubject = true
        getBySubject()
    }
    @objc func classClicked() {
        subjectViewActive.backgroundColor = .clear
        classViewActive.backgroundColor = ACColor.MAIN
        isSubject = false
        getByClass()
    }
    func getBySubject() {
        ACData.SUBJECTTEACHERBYSUBJECT.removeAll()
        ACRequest.POST_SEE_SUBJECT_TEACHER_BY_SUBJECT(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            ACData.SUBJECTTEACHERBYSUBJECT = jsonDatas
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func getByClass() {
        ACData.SUBJECTTEACHERBYCLASS.removeAll()
        ACRequest.POST_SEE_SUBJECT_TEACHER_BY_CLASS(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            ACData.SUBJECTTEACHERBYCLASS = jsonDatas
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension SubjectTeacherViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return isSubject ? ACData.SUBJECTTEACHERBYSUBJECT.count : ACData.SUBJECTTEACHERBYCLASS.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSubject ? 1 + ACData.SUBJECTTEACHERBYSUBJECT[section].class_shift.count : 1 + ACData.SUBJECTTEACHERBYCLASS[section].class_schedules.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectTeacherSectionCellID", for: indexPath) as? SubjectTeacherSectionCell)!
            if !isSubject {
                cell.detailClassObj = ACData.SUBJECTTEACHERBYCLASS[indexPath.section]
            } else {
                cell.detailObj = ACData.SUBJECTTEACHERBYSUBJECT[indexPath.section]
            }

            return cell
        } else {
            if isSubject {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectTeacherRowCellID", for: indexPath) as? SubjectTeacherRowCell)!
                cell.indexCell = indexPath.row - 1
                cell.detailObj = ACData.SUBJECTTEACHERBYSUBJECT[indexPath.section].class_shift[indexPath.row-1]
                cell.delegate = self
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "classTeacherRowCellID", for: indexPath) as? ClassTeacherRowCell)!
                cell.indexCell = indexPath.row - 1
                cell.detailObj = ACData.SUBJECTTEACHERBYCLASS[indexPath.section].class_schedules[indexPath.row-1]
                cell.delegate = self
                return cell
            }
        }
    }
}

extension SubjectTeacherViewController: ClassTeacherRowCellDelegate, SubjectTeacherRowCellDelegate {
    func goToSubjectTeacherList() {
        let subjectTeacherVC = SubjectTeacherListViewController()
        self.navigationController?.pushViewController(subjectTeacherVC, animated: true)
    }
    func goToSubjectTeacherListByClass(withSubjectID: String, withSchoolClassID: String) {
        let subjectTeacherByClassVC = SubjectTeacherByClassViewController()
        subjectTeacherByClassVC.subjectID = withSubjectID
        subjectTeacherByClassVC.schoolClassID = withSchoolClassID
        self.navigationController?.pushViewController(subjectTeacherByClassVC, animated: true)
    }
}
