//
//  ExamViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 07/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class ExamViewController: UIViewController {

    @IBOutlet weak var addExamButtin: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var listCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        fetchData()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Exam", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Exam", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "ExamCell", bundle: nil), forCellReuseIdentifier: "examCellID")
        tableView.register(UINib(nibName: "AllExamSectionCell", bundle: nil), forCellReuseIdentifier: "allExamSectionCellID")
        addExamButtin.addTarget(self, action: #selector(addExamAction), for: .touchUpInside)
    }
    @objc func addExamAction() {
        let addExamVC = AddExamViewController()
        self.navigationController?.pushViewController(addExamVC, animated: true)
    }
    func fetchData() {
//        if ACData.EXAMLISTDATA != nil {
//            ACData.EXAMLISTDATA.exam_subject_list.removeAll()
//            ACData.EXAMLISTDATA.exam_level_list.removeAll()
//            ACData.EXAMLISTDATA.exam_list.removeAll()
//        }
        ACRequest.GET_EXAM_LIST(
            userID: ACData.LOGINDATA.userID,
            role: ACData.LOGINDATA.role,
            schoolID: ACData.LOGINDATA.school_id,
            yearID: ACData.LOGINDATA.year_id,
            levelID: "",
            subjectID: "",
            tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            SVProgressHUD.dismiss()
            ACData.EXAMLISTDATA = jsonDatas
            self.listCount = ACData.EXAMLISTDATA.exam_list.count
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension ExamViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + listCount
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 56 : 77
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "allExamSectionCellID", for: indexPath) as? AllExamSectionCell)!
            cell.objectSubject = ACData.EXAMLISTDATA
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "examCellID", for: indexPath) as? ExamCell)!
            cell.delegate = self
            cell.examObj = ACData.EXAMLISTDATA.exam_list[indexPath.row-1]
            return cell
        }
    }
}

extension ExamViewController: ExamCellDelegate, AllExamSectionCellDelegate {
    func toExamDetail(withExamDetailIndex: String) {
        let examDetailVC = ExamDetailViewController()
        examDetailVC.examDetailIndex = withExamDetailIndex
        self.navigationController?.pushViewController(examDetailVC, animated: true)
    }
    func reloadTable() {
        listCount = ACData.EXAMLISTDATA.exam_list.count
        self.tableView.reloadData()
    }
}
