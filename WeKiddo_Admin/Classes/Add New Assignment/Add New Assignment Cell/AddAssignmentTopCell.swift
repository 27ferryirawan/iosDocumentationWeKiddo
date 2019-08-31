//
//  AddAssignmentTopCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 05/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SVProgressHUD

protocol AddAssignmentTopCellDelegate: class {
    func reloadAtIndex()
    func subjectSelected(withValue: String)
    func chapterSelected(withValue: String)
    func teacherSelected(withValue: String)
    func assignmentSelected(withValue: Int)
    func noteFilled(withValue: String)
}

class AddAssignmentTopCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var notesText: UITextView!
    @IBOutlet weak var projectStatusImage: UIImageView!
    @IBOutlet weak var homeworkStatusImage: UIImageView!
    @IBOutlet weak var projectButton: UIButton!
    @IBOutlet weak var homeworkButton: UIButton!
    @IBOutlet weak var topicPickerButton: UIButton!
    @IBOutlet weak var subjectPickerButton: UIButton!
    @IBOutlet weak var teacherPickerButton: UIButton!
    var isHomeWork = Bool()
    var isFromEdit = Bool()
    var chapterID = ""
    var teacherID = ""
    var subjectID = ""
    var chapterName = [String]()
    var teacherName = [String]()
    var subjectName = [String]()
    var subjectObj: AssignmentSubjectListModel? {
        didSet {
            cellConfigSubject()
        }
    }
    var teacherObj: AssignmentTeacherListModel? {
        didSet {
            cellConfigTeacher()
        }
    }
    var chapterObj: AssignmentChapterListModel? {
        didSet {
            cellConfigChapter()
        }
    }
    var detailSubjectEdit: AssignmentDetailEditModel? {
        didSet {
            cellEditConfig()
        }
    }
    weak var delegate: AddAssignmentTopCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        homeworkButton.addTarget(self, action: #selector(homeworkSelected), for: .touchUpInside)
        projectButton.addTarget(self, action: #selector(projectSelected), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellEditConfig() {
        subjectPickerButton.setTitle(ACData.ASSIGNMENTDETAILEDITDATA.subject_name, for: .normal)
        topicPickerButton.setTitle(ACData.ASSIGNMENTDETAILDATA.chapter_name, for: .normal)
        chapterName.removeAll()
        for index in ACData.ASSIGNMENTDETAILEDITDATA.schoolChapter {
            self.chapterName.append(index.chapter_name)
        }
        if ACData.ASSIGNMENTDETAILEDITDATA.assignment_type == "1" {
            homeworkStatusImage.image = UIImage(named: "radio-on-button")
            projectStatusImage.image = UIImage(named: "circumference")
            isHomeWork = true
            self.delegate?.assignmentSelected(withValue: 1)
        } else {
            homeworkStatusImage.image = UIImage(named: "circumference")
            projectStatusImage.image = UIImage(named: "radio-on-button")
            isHomeWork = false
            self.delegate?.assignmentSelected(withValue: 2)
        }
        notesText.text = ACData.ASSIGNMENTDETAILEDITDATA.note
    }
    func cellConfigSubject() {
        guard let list = subjectObj?.subjectList else {return}
        subjectName.removeAll()
        for item in list{
            subjectName.append(item.subject_name)
        }
        subjectPickerButton.addTarget(self, action: #selector(showSubjectPicker), for: .touchUpInside)
        subjectPickerButton.isUserInteractionEnabled = true
        self.subjectPickerButton.setTitle("Select Subject", for: .normal)
    }
    func cellConfigTeacher() {
        guard let list = teacherObj?.assignmentTeacherList else {return}
        teacherName.removeAll()
        self.teacherID = list.first?.teacher_id ?? ""
        self.teacherPickerButton.setTitle(list.first?.teacher_name ?? "", for: .normal)
        self.fetchSubjectList()
        for item in list{
            teacherName.append(item.teacher_name)
        }
        teacherPickerButton.addTarget(self, action: #selector(showTeacherPicker), for: .touchUpInside)
        teacherPickerButton.isUserInteractionEnabled = true
    }
    func cellConfigChapter() {
        guard let list = chapterObj?.chapterList else {return}
        chapterName.removeAll()
        for item in list {
            chapterName.append(item.chapter_name)
        }
        topicPickerButton.addTarget(self, action: #selector(showTopicPicker), for: .touchUpInside)
        topicPickerButton.isUserInteractionEnabled = true
        self.topicPickerButton.setTitle("Select Topic", for: .normal)
    }
    @objc func homeworkSelected() {
        print("homework")
        homeworkStatusImage.image = UIImage(named: "radio-on-button")
        projectStatusImage.image = UIImage(named: "circumference")
        isHomeWork = true
        self.delegate?.assignmentSelected(withValue: 1)
    }
    @objc func projectSelected() {
        print("project")
        homeworkStatusImage.image = UIImage(named: "circumference")
        projectStatusImage.image = UIImage(named: "radio-on-button")
        isHomeWork = false
        self.delegate?.assignmentSelected(withValue: 2)
    }
    @objc func showSubjectPicker() {
        ActionSheetStringPicker.show(
            withTitle: "Select Subject",
            rows: subjectName,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let selectedValue = values as? String else {return}
                self.subjectPickerButton.setTitle(selectedValue, for: .normal)
                self.subjectID = self.subjectObj?.subjectList[indexes].subject_id ?? ""
                self.delegate?.subjectSelected(withValue: self.subjectID)
                self.fetchChapterList()
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showTopicPicker() {
        ActionSheetStringPicker.show(
            withTitle: "Select Topic",
            rows: chapterName,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let selectedValue = values else { return }
                self.topicPickerButton.setTitle("\(selectedValue)", for: .normal)
                if self.isFromEdit {
                    self.chapterID = ACData.ASSIGNMENTDETAILEDITDATA.schoolChapter[indexes].chapter_id
                } else {
                    self.chapterID = self.chapterObj?.chapterList[indexes].chapter_id ?? ""
                }
                self.delegate?.chapterSelected(withValue: self.chapterID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showTeacherPicker() {
        ActionSheetStringPicker.show(
            withTitle: "Select Teacher",
            rows: teacherName,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let selectedValue = values else { return }
                self.teacherPickerButton.setTitle("\(selectedValue)", for: .normal)
                if self.isFromEdit {
                    self.teacherID = ACData.ASSIGNMENTTEACHERLISTALL.assignmentTeacherList[indexes].teacher_id
                } else {
                    self.teacherID = self.teacherObj?.assignmentTeacherList[indexes].teacher_id ?? ""
                }
                self.fetchSubjectList()
                self.delegate?.teacherSelected(withValue: self.teacherID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    func fetchSubjectList(){
        //TODO: Change Value for school ID and yearID
        self.subjectID = ""
        self.subjectPickerButton.setTitle("Select Subject", for: .normal)
        ACRequest.POST_ASSIGNMENT_GET_SUBJECT(userId: ACData.LOGINDATA.userID, schoolId: ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "", yearId: ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",school_user_id: self.teacherID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (subjectList) in
            ACData.ASSIGNMENTSUBJECTLIST = subjectList
            self.subjectObj = subjectList
            SVProgressHUD.dismiss()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func fetchChapterList(){
        //TODO: Change Value for school ID and yearID
        self.chapterID = ""
        self.topicPickerButton.setTitle("Select Topic", for: .normal)
        ACRequest.POST_ASSIGNMENT_GET_CHAPTER_LIST(userId: ACData.LOGINDATA.userID, schoolId: ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "", yearId: ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",school_user_id: self.teacherID, subject_id: self.subjectID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (chapterList) in
            ACData.ASSIGNMENTCHAPTERLIST = chapterList
            self.chapterObj = chapterList
            SVProgressHUD.dismiss()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let currentText = (textView.text as NSString?)?.replacingCharacters(in: range, with: text) else {return true}
        if (currentText == "\n") {
            textView.resignFirstResponder()
            return false
        }
        self.delegate?.noteFilled(withValue: currentText)
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Assignment Notes"
            textView.textColor = UIColor.lightGray
        }
    }
}
