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
    var subjectName = [String]()
    var chapterID = ""
    var teacherID = ""
    var topicName = [String]()
    var teacherName = [String]()
    var subjectObj: SubjectModel? {
        didSet {
            cellConfig()
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
        topicPickerButton.addTarget(self, action: #selector(showTopicPicker), for: .touchUpInside)
        teacherPickerButton.addTarget(self, action: #selector(showTeacherPicker), for: .touchUpInside)
        self.topicPickerButton.setTitle("Select Topic", for: .normal)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellEditConfig() {
        subjectPickerButton.setTitle(ACData.ASSIGNMENTDETAILEDITDATA.subject_name, for: .normal)
        topicPickerButton.setTitle(ACData.ASSIGNMENTDETAILDATA.chapter_name, for: .normal)
        topicName.removeAll()
        for index in ACData.ASSIGNMENTDETAILEDITDATA.schoolChapter {
            self.topicName.append(index.chapter_name)
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
    func cellConfig() {
        //        if !isFromEdit {
        for index in ACData.SUBJECTDATA {
            subjectName.append(index.subject_name)
        }
        subjectPickerButton.addTarget(self, action: #selector(showSubjectPicker), for: .touchUpInside)
        subjectPickerButton.isUserInteractionEnabled = true
        //        } else {
        //
        //        }
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
                self.subjectPickerButton.setTitle(self.subjectName[indexes], for: .normal)
                let subjectID = ACData.SUBJECTDATA[indexes].subject_id
                self.fetchData(index: subjectID)
                self.delegate?.subjectSelected(withValue: subjectID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func showTopicPicker() {
        ActionSheetStringPicker.show(
            withTitle: "Select Topic",
            rows: topicName,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let selectedValue = values else { return }
                self.topicPickerButton.setTitle("\(selectedValue)", for: .normal)
                if self.isFromEdit {
                    self.chapterID = ACData.ASSIGNMENTDETAILEDITDATA.schoolChapter[indexes].chapter_id
                } else {
                    self.chapterID = ACData.CHAPTERDATA.chapter_list[indexes].chapter_id
                }
                
                self.delegate?.chapterSelected(withValue: self.chapterID)
                self.delegate?.reloadAtIndex()
                //                let subjectID = ACData.SUBJECTDATA[indexes].subject_id
                //                self.fetchData(index: subjectID)
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
                self.topicPickerButton.setTitle("\(selectedValue)", for: .normal)
                if self.isFromEdit {
                    self.teacherID = ACData.ASSIGNMENTTEACHERLISTALL.assignmentTeacherList[indexes].teacher_id
                } else {
                    self.teacherID = ACData.CHAPTERDATA.chapter_list[indexes].chapter_id
                }
                
                self.delegate?.teacherSelected(withValue: self.teacherID)
                self.delegate?.reloadAtIndex()
                //                let subjectID = ACData.SUBJECTDATA[indexes].subject_id
                //                self.fetchData(index: subjectID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    func fetchData(index: String) {
        topicName.removeAll()
        ACRequest.POST_CHAPTER_LIST(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, subjectID: index, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (chapterData) in
            ACData.CHAPTERDATA = chapterData
            for index in ACData.CHAPTERDATA.chapter_list {
                self.topicName.append(index.chapter_name)
            }
            SVProgressHUD.dismiss()
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        self.delegate?.noteFilled(withValue: textView.text!)
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
