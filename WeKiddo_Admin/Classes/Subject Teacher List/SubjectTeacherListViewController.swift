//
//  SubjectTeacherListViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 13/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class SubjectTeacherListViewController: UIViewController {

    @IBOutlet weak var addTopic: UIButton!
    @IBOutlet weak var tableVie: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Subject Teacher List", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableVie.register(UINib(nibName: "SubjectTeacherListCell", bundle: nil), forCellReuseIdentifier: "subjectTeacherListCellID")
        addTopic.addTarget(self, action: #selector(addTopicAction), for: .touchUpInside)
    }
    @objc func addTopicAction() {
        ACRequest.POST_GET_PARAM_FOR_ADD_SUBJECT_TEACHER(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, schoolLevelID: ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_level_id, subjectID: ACData.SUBJECTTEACHERCHAPTERLISTDATA.subject_id, schoolGradeID: ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_grade_id, schoolMajorID: ACData.SUBJECTTEACHERCHAPTERLISTDATA.school_major_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            SVProgressHUD.dismiss()
            ACData.SUBJECTTEACHERPARAMMODEL = jsonDatas
            let addVC = AddSubjectTeacherViewController()
            addVC.isFromEdit = false
            self.navigationController?.pushViewController(addVC, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}

extension SubjectTeacherListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.SUBJECTTEACHERCHAPTERLISTDATA.topic_list.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectTeacherListCellID", for: indexPath) as? SubjectTeacherListCell)!
        cell.detailObj = ACData.SUBJECTTEACHERCHAPTERLISTDATA.topic_list[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension SubjectTeacherListViewController: SubjectTeacherListCellDelegate {
    func goToSubjectTeacherDetail() {
        let subjectDetailVC = SubjectTeacherDetailViewController()
        self.navigationController?.pushViewController(subjectDetailVC, animated: true)
    }
}
