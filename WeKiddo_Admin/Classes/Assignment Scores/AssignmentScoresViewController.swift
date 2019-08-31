//
//  AssignmentScoresViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 06/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class AssignmentScoresViewController: UIViewController {

    @IBOutlet weak var subjectLabel: UILabel!
    var studentModel = [ScoreStudent]()
    @IBOutlet weak var headerView: UIView! {
        didSet {
            headerView.setBorderShadow(color: UIColor.gray, shadowRadius: 1.0, shadowOpactiy: 1, shadowOffsetWidth: Int(0.5), shadowOffsetHeight: 1)
        }
    }
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        for item in ACData.SCORELISTDATA.student_list {
            studentModel.append(ScoreStudent(child_id: item.child_id, score: item.score, child_image: item.child_image, child_name: item.child_name, exam_score: 0))
        }
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Assignment - Scores", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "AssignmentScoreHeaderCell", bundle: nil), forCellReuseIdentifier: "assignmentScoreHeaderCell")
        tableView.register(UINib(nibName: "AssignmentScoreStudentCell", bundle: nil), forCellReuseIdentifier: "assignmentScoreStudentCellID")
        tableView.register(UINib(nibName: "AssignmentScoreFooterCell", bundle: nil), forCellReuseIdentifier: "assignmentScoreFooterCellID")
    }
}

extension AssignmentScoresViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + studentModel.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 22
        } else if indexPath.row <= studentModel.count {
            return 66
        } else {
            return 55
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "assignmentScoreHeaderCell", for: indexPath) as? AssignmentScoreHeaderCell)!
            return cell
        } else if indexPath.row <= studentModel.count {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "assignmentScoreStudentCellID", for: indexPath) as? AssignmentScoreStudentCell)!
            cell.studentObj = studentModel[indexPath.row - 1]
            cell.index = indexPath.row - 1
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "assignmentScoreFooterCellID", for: indexPath) as? AssignmentScoreFooterCell)!
            cell.delegate = self
            return cell
        }
    }
}

extension AssignmentScoresViewController: AssignmentScoreStudentCellDelegate, AssignmentScoreFooterCellDelegate {
    func scoreFilled(withIndex: Int, withChildID: String, withScore: Int) {
        studentModel[withIndex].score = withScore
        tableView.reloadRows(at: [IndexPath(row: withIndex, section: 0)], with: UITableView.RowAnimation.none)
        print(studentModel.count)
    }
    func submitAction() {
        guard let teacherID = ACData.ASSIGNMENTTEACHERLISTALL.assignmentTeacherList.first(where: {$0.teacher_name ==  ACData.ASSIGNMENTDETAILDATA.teacher_name})?.teacher_id else { return }
        for index in studentModel {
            print(index.childID)
        }
        var addOn = "["
        var i = 0
        for data in studentModel {
            if i > 0 {
                addOn += ","
            }
            addOn += "{"
            addOn += "\"child_id\":\"\(data.childID)\","
            addOn += "\"score\":\"\(data.score)\""
            addOn += "}"
            
            i += 1
        }
        addOn += "]"
        //TODO : Change value of teacherID, schoolID, and yearID
        let newaddOn = addOn.replacingOccurrences(of: "\\", with: "")
        let jsonData = newaddOn.data(using: .utf8)!
        let jsonO = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
        let parameters: Parameters = [
            "user_id":ACData.LOGINDATA.userID,
            "school_user_id":teacherID,
            "school_id":ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
            "year_id":ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
            "assign_id":ACData.SCORELISTDATA.assignment_id,
            "class_id":ACData.SCORELISTDATA.school_class_id,
            "student_list":jsonO
        ]
        print(parameters)
        ACRequest.POST_UPDATE_SCORE(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}
