//
//  ExamDetailViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 08/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage
import Alamofire

class ExamDetailViewController: UIViewController {

    @IBOutlet weak var removeView: UIView!
    @IBOutlet weak var btClosePopUp: UIButton!
    @IBOutlet weak var ivAvatarStudent: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbNis: UILabel!
    @IBOutlet weak var btRemoveStudent: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    var sessionDataCount = 0
    var relatedExamCount = 0
    var examDetailIndex = ""
    var teacherID = ""
    var remediScheduleCount = 0
    var sessionSelectedCount = 0
    
    var selectedRemedyID = ""
    var studentObj: StudentsRemedyModel?{
        didSet{
            removePopUpConfig()
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateData()
//        fetchData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        removeView.isHidden = true
        configNavigation()
        configTable()
    }
    func removePopUpConfig(){
        removeView.isHidden = false
        removeView.layer.cornerRadius = 10
        removeView.layer.borderColor = UIColor.black.cgColor
        removeView.layer.borderWidth = 1
        
        guard let obj = studentObj else { return }
        btClosePopUp.addTarget(self, action: #selector(closePopUp), for: .touchUpInside)
        btRemoveStudent.addTarget(self, action: #selector(removeStudent), for: .touchUpInside)
        ivAvatarStudent.sd_setImage(with: URL(string: obj.child_image), placeholderImage: nil, options: .refreshCached)
        lbName.text = obj.child_name
        lbNis.text = obj.child_nis
    }
    
    @objc func closePopUp(){
        removeView.isHidden = true
        studentObj = nil
        self.selectedRemedyID = ""
    }
    
    @objc func removeStudent(){
        guard let obj = studentObj else { return }
        //TODO: Change value of schoolID and YearID
        let parameters: Parameters = [
            "user_id":ACData.LOGINDATA.userID,
            "school_id":"SCHOOL10",
            "year_id":"YEAR1",
            "school_user_id":ACData.EXAMDETAILDATA.teacher.teacher_id,
            "exam_remedy_id":selectedRemedyID,
            "child_id": obj.child_id
        ]
        
        ACRequest.POST_EXAM_REMOVE_STUDENT(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: {
            SVProgressHUD.dismiss()
            self.removeView.isHidden = true
            self.studentObj = nil
            self.selectedRemedyID = ""
        }) { (message) in
            ACAlert.show(message: message)
            SVProgressHUD.dismiss()
            self.removeView.isHidden = true
            self.studentObj = nil
            self.selectedRemedyID = ""
        }
    }
    
    func fetchData() {
        //TODO : Change value of schoolID and yearID
        ACRequest.GET_EXAM_DETAIL(
            userID: ACData.LOGINDATA.userID,
            school_user_id: teacherID,
            schoolID: "SCHOOL10",//ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
            yearID: "YEAR1",//ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
            examID: examDetailIndex,
            tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (detailData) in
            SVProgressHUD.dismiss()
            ACData.EXAMDETAILDATA = detailData
            self.populateData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func populateData() {
        sessionDataCount = ACData.EXAMDETAILDATA.sessions.count
        
        for i in ACData.EXAMDETAILDATA.sessions {
            sessionSelectedCount += i.session_list.count
        }

        relatedExamCount = ACData.EXAMDETAILDATA.related.count
        remediScheduleCount = ACData.EXAMDETAILDATA.remedy.count
        self.tableView.reloadData()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Exam Detail", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "ExamDetailCell", bundle: nil), forCellReuseIdentifier: "examDetailCellID")
        tableView.register(UINib(nibName: "ExamDetailSessionCell", bundle: nil), forCellReuseIdentifier: "examDetailSessionCellID")
        tableView.register(UINib(nibName: "ExamDetailSectionCell", bundle: nil), forCellReuseIdentifier: "examDetailSectionCellID")
        tableView.register(UINib(nibName: "ExamDetailRelatedExamCell", bundle: nil), forCellReuseIdentifier: "examDetailRelatedExamCellID")
        tableView.register(UINib(nibName: "ExamDetailRemediScheduleCell", bundle: nil), forCellReuseIdentifier: "examDetailRemediScheduleCellID")
        tableView.register(UINib(nibName: "ExamDetailFooterCell", bundle: nil), forCellReuseIdentifier: "examDetailFooterCellID")
    }
}

extension ExamDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4 + sessionDataCount
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section <= sessionDataCount {
            return ACData.EXAMDETAILDATA.sessions[section-1].session_list.count
        } else if section == 1 + sessionDataCount {
            return relatedExamCount
        } else if section == 2 + sessionDataCount {
            return remediScheduleCount
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else if section <= sessionDataCount {
            return "Week \(ACData.EXAMDETAILDATA.sessions[section-1].week_count)(\(ACData.EXAMDETAILDATA.sessions[section-1].from_date) - \(ACData.EXAMDETAILDATA.sessions[section-1].end_date))"
        } else if section == 1 + sessionDataCount {
            return "Related Exams"
        } else if section == 2 + sessionDataCount {
            return "Remedi Schedules"
        } else {
            return ""
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 260
        } else if indexPath.section <= sessionDataCount {
            return 25
        } else if indexPath.section == 1 + sessionDataCount {
            return 44
        } else if indexPath.section == 2 + sessionDataCount {
            return 200
        } else {
            return 242
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "examDetailCellID", for: indexPath) as? ExamDetailCell)!
            cell.examObj = ACData.EXAMDETAILDATA
            return cell
        } else if indexPath.section <= sessionDataCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "examDetailSessionCellID", for: indexPath) as? ExamDetailSessionCell)!
            cell.detailObj = ACData.EXAMDETAILDATA.sessions[indexPath.section - 1].session_list[indexPath.row]
            return cell
        } else if indexPath.section == 1 + sessionDataCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "examDetailRelatedExamCellID", for: indexPath) as? ExamDetailRelatedExamCell)!
            cell.detailObj = ACData.EXAMDETAILDATA.related[indexPath.row]
            return cell
        } else if indexPath.section == 2 + sessionDataCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "examDetailRemediScheduleCellID", for: indexPath) as? ExamDetailRemediScheduleCell)!
            cell.indexRow = indexPath.row + 1
            cell.detailObj = ACData.EXAMDETAILDATA.remedy[indexPath.row]
            cell.teacherID = teacherID
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "examDetailFooterCellID", for: indexPath) as? ExamDetailFooterCell)!
            cell.detailObj = ACData.EXAMDETAILDATA
            cell.delegate = self
            return cell
        }
    }
}

extension ExamDetailViewController: ExamDetailRemediScheduleCellDelegate, AddDetentionStudentSearchViewControllerDelegate, ExamDetailFooterCellDelegate {
    func sendSelectedStudent(withStudentArray: [StudentSearchSelected]) {
        
    }
    func toAddScore() {
        let addScoreVC = AddScoreExamViewController()
        self.navigationController?.pushViewController(addScoreVC, animated: true)
    }
    func toEditExam() {
        let editExamVC = EditExamViewController()
        self.navigationController?.pushViewController(editExamVC, animated: true)
    }
    func closeExam() {
        self.navigationController?.popViewController(animated: true)
    }
    func refreshExamRemedyTableWithIndex(index: String) {
        examDetailIndex = index
        fetchData()
    }
    func toEdit(withRemediID: String) {
        let examEditScoreVC = ExamScoreViewController()
        examEditScoreVC.remediID = withRemediID
        self.navigationController?.pushViewController(examEditScoreVC, animated: true)
    }
    func toAddStudent(withRemediID: String) {
        let searchVC = AddDetentionStudentSearchViewController()
        searchVC.isFromAnnouncement = false
        searchVC.isFromExamRemedy = true
        searchVC.isFromEventPayment = false
        searchVC.examSchoolRemedyID = examDetailIndex
        searchVC.examRemedyID = withRemediID
        let navVC = UINavigationController(rootViewController: searchVC)
        self.navigationController?.present(navVC, animated: true, completion: nil)
    }
    func didSelectStudent(with obj: StudentsRemedyModel, examID: String) {
        studentObj = obj
        selectedRemedyID = examID
    }
}
