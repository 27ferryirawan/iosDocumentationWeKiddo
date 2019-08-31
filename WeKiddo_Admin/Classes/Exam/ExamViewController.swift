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
    var teacherID = ""
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
        tableView.register(UINib(nibName: "ExamTeacherCell", bundle: nil), forCellReuseIdentifier: "examTeacherCell")
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
        //TODO : Change value of schoolID and YearID
        ACRequest.POST_GET_EXAM_TEACHER_LIST_ALL(
            userID: ACData.LOGINDATA.userID,
            schoolID: ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
            yearID: ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
            tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            SVProgressHUD.dismiss()
            ACData.EXAMTEACHERLISTALL = jsonDatas
            self.listCount = ACData.EXAMTEACHERLISTALL.teacherList.count
            self.tableView.reloadData()
        }, failCompletion: { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        })
    }
}

extension ExamViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if ACData.EXAMTEACHERLISTALL == nil{
            return 1
        } else if !teacherID.isEmpty {
            return 2
        }
        return ACData.EXAMTEACHERLISTALL.teacherList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        var itemsCount = 0
        if ACData.EXAMLISTADMIN != nil{
            if ACData.EXAMLISTADMIN.examList.count > section - 1{
                itemsCount = ACData.EXAMLISTADMIN.examList[section - 1].exams.count
            }
        }
        return 1 + itemsCount
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 56 : 77
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = (tableView.dequeueReusableCell(withIdentifier: "allExamSectionCellID", for: indexPath) as? AllExamSectionCell)!
            cell.objTeacher = ACData.EXAMTEACHERLISTALL
            cell.delegate = self
            return cell
        } else {
            if indexPath.row == 0 {
                if ACData.EXAMLISTADMIN != nil, ACData.EXAMLISTADMIN.examList.count > indexPath.section - 1{
                    let cell = (tableView.dequeueReusableCell(withIdentifier: "examTeacherCell", for: indexPath) as? ExamTeacherCell)!
                    cell.objExam = ACData.EXAMLISTADMIN.examList[indexPath.section-1]
                    return cell
                } else {
                    return UITableViewCell()
                }
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "examCellID", for: indexPath) as? ExamCell)!
                cell.delegate = self
                if ACData.EXAMLISTADMIN != nil,
                    ACData.EXAMLISTADMIN.examList.count > indexPath.section - 1,
                    ACData.EXAMLISTADMIN.examList[indexPath.section-1].exams.count > indexPath.row - 1{
                    cell.examObj = ACData.EXAMLISTADMIN.examList[indexPath.section-1].exams[indexPath.row-1]
                }
                return cell
            }
        }
    }
}

extension ExamViewController: ExamCellDelegate, AllExamSectionCellDelegate {
    func didSelectTeacher(with value: String) {
        //TODO : Change value of schoolID and YearID
        self.teacherID = value
        ACRequest.GET_EXAM_LIST(
            userID: ACData.LOGINDATA.userID,
            school_user_id: self.teacherID,
            schoolID: ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
            yearID:  ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
            tokenAccess: ACData.LOGINDATA.accessToken,
            successCompletion: { (data) in
                ACData.EXAMLISTADMIN = data
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: "Your internet connection have a problem")
        }
    }
    
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
