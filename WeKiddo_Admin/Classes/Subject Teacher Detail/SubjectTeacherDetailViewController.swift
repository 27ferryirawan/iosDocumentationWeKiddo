//
//  SubjectTeacherDetailViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 13/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SubjectTeacherDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color:  UIColor.gray, shadowRadius: 3.0, shadowOpactiy: 1, shadowOffsetWidth: 3, shadowOffsetHeight: 3)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    var sessionCount = 0
    var classCount = 0
    var attachmentCount = 0
    var voiceNotesCount = 0
    var attachmentArray = [SubjectTeacherDetailMediasModel]()
    var voiceNoteArray = [SubjectTeacherDetailMediasModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        populateData()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Subject Teacher Detail", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func populateData() {
        titleLabel.text = "\(ACData.SUBJECTTEACHERDETAILMODEL.school_level) - \(ACData.SUBJECTTEACHERDETAILMODEL.subject_name)"
        sessionCount = ACData.SUBJECTTEACHERDETAILMODEL.subject_chapter_detail_session_week.count
        classCount = ACData.SUBJECTTEACHERDETAILMODEL.subject_chapter_classes.count
        for mediaObj in ACData.SUBJECTTEACHERDETAILMODEL.subject_chapter_medias {
            if mediaObj.media_type_id == "MT6" {
                voiceNoteArray.append(mediaObj)
            } else {
                attachmentArray.append(mediaObj)
            }
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "SubjectTeacherDetailHeaderCell", bundle: nil), forCellReuseIdentifier: "subjectTeacherDetailHeaderCellID")
        tableView.register(UINib(nibName: "SubjectTeacherDetailSessionCell", bundle: nil), forCellReuseIdentifier: "subjectTeacherDetailSessionCellID")
        tableView.register(UINib(nibName: "SubjectTeacherDetailClassCell", bundle: nil), forCellReuseIdentifier: "subjectTeacherDetailClassCellID")
        tableView.register(UINib(nibName: "SubjectTeacherDetailClassContentCell", bundle: nil), forCellReuseIdentifier: "subjectTeacherDetailClassContentCellID")
        tableView.register(UINib(nibName: "SubjectTeacherDetailAttachmentCell", bundle: nil), forCellReuseIdentifier: "subjectTeacherDetailAttachmentCellID")
        tableView.register(UINib(nibName: "SubjectTeacherDetailExamCell", bundle: nil), forCellReuseIdentifier: "subjectTeacherDetailExamCellID")
        tableView.register(UINib(nibName: "SubjectTeacherDetailFooterCell", bundle: nil), forCellReuseIdentifier: "subjectTeacherDetailFooterCellID")
    }
}

extension SubjectTeacherDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5 + sessionCount
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section < 1 + sessionCount {
            return ACData.SUBJECTTEACHERDETAILMODEL.subject_chapter_detail_session_week[section-1].sessions.count
        } else if section == 1 + sessionCount {
            return classCount
        } else if section == 2 + sessionCount {
            return attachmentArray.count
        } else if section == 3 + sessionCount {
            return voiceNoteArray.count
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 25))
        bgView.backgroundColor = .clear
        let dateLabel = UILabel(frame: CGRect(x: 10, y: 0, width: bgView.frame.size.width - 10, height: 25))
        dateLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        dateLabel.textColor = .black
        dateLabel.numberOfLines = 0
//        dateLabel.text = ACData.UPCOMINGSESSIONLISTDATA[section].dateForHuman
        if section == 0 {
            dateLabel.text = ""
        } else if section < 1 + sessionCount {
            dateLabel.text = "Week \(ACData.SUBJECTTEACHERDETAILMODEL.subject_chapter_detail_session_week[section-1].week_count) (\(ACData.SUBJECTTEACHERDETAILMODEL.subject_chapter_detail_session_week[section-1].from_date) - \(ACData.SUBJECTTEACHERDETAILMODEL.subject_chapter_detail_session_week[section-1].end_date))"
        } else if section == 1 + sessionCount {
            dateLabel.text = "Class"
        } else if section == 2 + sessionCount {
            dateLabel.text = "Attachment"
        } else if section == 3 + sessionCount {
            dateLabel.text = "Voice Notes"
        } else {
            dateLabel.text = "Exam"
        }

        bgView.addSubview(dateLabel)
        return bgView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else if indexPath.section < 1 + sessionCount {
            return 33
        } else if indexPath.section == 1 + sessionCount {
            return 44
        } else if indexPath.section == 2 + sessionCount {
            return 44
        } else if indexPath.section == 3 + sessionCount {
            return 44
        } else {
            return 220
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectTeacherDetailHeaderCellID", for: indexPath) as? SubjectTeacherDetailHeaderCell)!
            cell.detailObj = ACData.SUBJECTTEACHERDETAILMODEL
            return cell
        } else if indexPath.section < 1 + sessionCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectTeacherDetailSessionCellID", for: indexPath) as? SubjectTeacherDetailSessionCell)!
            cell.detailObj = ACData.SUBJECTTEACHERDETAILMODEL.subject_chapter_detail_session_week[indexPath.section-1].sessions[indexPath.row]
            return cell
        } else if indexPath.section == 1 + sessionCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectTeacherDetailClassContentCellID", for: indexPath) as? SubjectTeacherDetailClassContentCell)!
            cell.detailObj = ACData.SUBJECTTEACHERDETAILMODEL.subject_chapter_classes[indexPath.row]
            return cell
        } else if indexPath.section == 2 + sessionCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectTeacherDetailAttachmentCellID", for: indexPath) as? SubjectTeacherDetailAttachmentCell)!
            return cell
        } else if indexPath.section == 3 + sessionCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectTeacherDetailAttachmentCellID", for: indexPath) as? SubjectTeacherDetailAttachmentCell)!
            cell.detailObj = ACData.SUBJECTTEACHERDETAILMODEL.subject_chapter_medias[indexPath.row]
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "subjectTeacherDetailExamCellID", for: indexPath) as? SubjectTeacherDetailExamCell)!
            cell.detailObj = ACData.SUBJECTTEACHERDETAILMODEL
            cell.delegate = self
            return cell
        }
    }
}

extension SubjectTeacherDetailViewController: SubjectTeacherDetailExamCellDelegate {
    func editSubjectTeacher() {
        let editVC = AddSubjectTeacherViewController()
        editVC.isFromEdit = true
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}
