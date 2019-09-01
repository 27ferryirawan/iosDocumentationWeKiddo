//
//  ExamScoreViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 24/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class ExamScoreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var classLabel: UILabel!
    var studentCount = 0
    var remediID = ""
    private var studentModel = [ScoreStudent]()
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Score", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "ExamScoreHeaderCell", bundle: nil), forCellReuseIdentifier: "examScoreHeaderCellID")
        tableView.register(UINib(nibName: "ExamScoreStudentCell", bundle: nil), forCellReuseIdentifier: "examScoreStudentCellID")
        tableView.register(UINib(nibName: "ExamScoreFooterCell", bundle: nil), forCellReuseIdentifier: "examScoreFooterCellID")
    }
    func populateData() {
        studentCount = ACData.EXAMREMEDYSCORELISTDATA.student_list.count
        for item in ACData.EXAMREMEDYSCORELISTDATA.student_list {
            studentModel.append(ScoreStudent(child_id: item.child_id, score: item.exam_score, child_image: item.child_image, child_name: item.child_name, exam_score: 0))
        }
    }
}

extension ExamScoreViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + studentModel.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 105
        } else if indexPath.row <= studentModel.count {
            return 66
        } else {
            return 44
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "examScoreHeaderCellID", for: indexPath) as? ExamScoreHeaderCell)!
            cell.detailObj = ACData.EXAMREMEDYSCORELISTDATA
            return cell
        } else if indexPath.row <= studentModel.count {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "examScoreStudentCellID", for: indexPath) as? ExamScoreStudentCell)!
            cell.detailObj = studentModel[indexPath.row-1]
            cell.index = indexPath.row - 1
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "examScoreFooterCellID", for: indexPath) as? ExamScoreFooterCell)!
            cell.delegate = self
            return cell
        }
    }
}

extension ExamScoreViewController: ExamScoreStudentCellDelegate, ExamScoreFooterCellDelegate {
    func refreshTable() {
        var addOn = "["
        var i = 0
        for data in studentModel {
            if i > 0 {
                addOn += ","
            }
            addOn += "{"
            addOn += "\"child_id\":\"\(data.childID)\","
            addOn += "\"remedy_score\":\"\(data.score)\""
            addOn += "}"
            
            i += 1
        }
        addOn += "]"
        
        let newaddOn = addOn.replacingOccurrences(of: "\\", with: "")
        let jsonData = newaddOn.data(using: .utf8)!
        let jsonO = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
        let parameters: Parameters = [
            "user_id":ACData.LOGINDATA.userID,
            "school_user_id":ACData.EXAMDETAILDATA.teacher.teacher_id,
            "exam_remedy_id":remediID,
            "chapter_id":ACData.EXAMREMEDYSCORELISTDATA.chapter_id,
            "class_id":ACData.EXAMREMEDYSCORELISTDATA.school_class_id,
            "student_list":jsonO
        ]
        print(parameters)
        
        ACRequest.POST_UPDATE_NEW_SCORE_EXAM_REMEDY(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func scoreFilled(withIndex: Int, withChildID: String, withScore: Int) {
        studentModel[withIndex].score = withScore
        tableView.reloadRows(at: [IndexPath(row: withIndex, section: 0)], with: UITableView.RowAnimation.none)
        print(studentModel.count)
    }
}
