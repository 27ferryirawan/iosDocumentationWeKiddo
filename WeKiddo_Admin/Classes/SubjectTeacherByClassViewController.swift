//
//  SubjectTeacherByClassViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 19/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class SubjectTeacherByClassViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var classLabel: UILabel!
    var subjectSelected = [[Int:SubjectTeacherByClassSessionSelected]]()
    var subjectID = ""
    var schoolClassID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Subject Teacher By Class", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "SubjectTeacherByClassHeaderCell", bundle: nil), forCellReuseIdentifier: "subjectTeacherByClassHeaderCellID")
        tableView.register(UINib(nibName: "SubjectTeacherByClassContentCell", bundle: nil), forCellReuseIdentifier: "subjectTeacherByClassContentCellID")
        saveButton.addTarget(self, action: #selector(saveSessionList), for: .touchUpInside)
    }
    @objc func saveSessionList() {
        var addOn = "["
        var i = 0

        for (ix,k) in subjectSelected.enumerated() {
            for (j,l) in k.enumerated(){
                if i > 0 {
                    addOn += ","
                }
                addOn += "{"
                addOn += "\"school_session_id\":\"\(l.value.school_session_id)\","
                addOn += "\"chapter_id\":\"\(l.value.chapter_id)\""
                addOn += "}"
    
                i += 1

            }
        }

        addOn += "]"
        
        let newaddOn = addOn.replacingOccurrences(of: "\\", with: "")
        let jsonData = newaddOn.data(using: .utf8)!
        let jsonO = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
        let parameters: Parameters = [
            "school_id":ACData.LOGINDATA.school_id,
            "year_id":ACData.LOGINDATA.year_id,
            "subject_id":self.subjectID,
            "school_class_id":self.schoolClassID,
            "user_id":ACData.LOGINDATA.userID,
            "role":ACData.LOGINDATA.role,
            "chapter":jsonO
        ]
        print(parameters)
        ACRequest.POST_UPDATE_SUBJECT_TEACHER_SESSION_LIST(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension SubjectTeacherByClassViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ACData.SUBJECTTEACHERBYCLASSSESSIONLISTDATA.detailed.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + ACData.SUBJECTTEACHERBYCLASSSESSIONLISTDATA.detailed[section].chapter.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 44
        } else {
            return 55
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectTeacherByClassHeaderCellID", for: indexPath) as? SubjectTeacherByClassHeaderCell)!
            cell.detailObj = ACData.SUBJECTTEACHERBYCLASSSESSIONLISTDATA.detailed[indexPath.section]
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectTeacherByClassContentCellID", for: indexPath) as? SubjectTeacherByClassContentCell)!
            cell.subjectSelected = self.subjectSelected
            cell.indexSection = indexPath.section
            cell.indexAt = indexPath.row - 1
            cell.detailObj = ACData.SUBJECTTEACHERBYCLASSSESSIONLISTDATA.detailed[indexPath.section].chapter[indexPath.row - 1]
            cell.delegate = self
            return cell
        }
    }
}

extension SubjectTeacherByClassViewController: SubjectTeacherByClassContentCellDelegate{
    func pickerSelectedWithIndex(section:Int, index: Int, name: String, chapterid: String) {
        let schoolSSID = ACData.SUBJECTTEACHERBYCLASSSESSIONLISTDATA.detailed[section].chapter[index].school_session_id
        subjectSelected.append([section : SubjectTeacherByClassSessionSelected(schoolSessionID: schoolSSID, chapterID: chapterid, chapterName: name, objectAtSection: section, objectAtIndex: index)])
        tableView.reloadRows(at: [IndexPath(row: index, section: section)], with: UITableView.RowAnimation.none)
    }
}
