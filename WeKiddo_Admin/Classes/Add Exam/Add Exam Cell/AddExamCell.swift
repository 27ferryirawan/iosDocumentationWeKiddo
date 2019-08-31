//
//  AddExamCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 25/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SVProgressHUD

protocol AddExamCellDelegate: class {
    func titleFilledWithValue(value: String)
    func descFilledWithValue(value: String)
    func subjectSelectedWithValue(value: String)
    func typeSelectedWithValue(value: String)
    func levelSelectedWithValue(value: String)
    func majorSelectedWithValue(value: String)
    func teacherSelected(with value: String)
}

class AddExamCell: UITableViewCell, UITextFieldDelegate, UITextViewDelegate/*, UICollectionViewDelegate, UICollectionViewDataSource*/ {

    @IBOutlet weak var examTeacherButton: UIButton!
    @IBOutlet weak var examMajorButton: UIButton!
    @IBOutlet weak var examLevelButton: UIButton!
    @IBOutlet weak var examSubjectButton: UIButton!
    @IBOutlet weak var examTypeButton: UIButton!
    @IBOutlet weak var examDescLabel: UITextView!
    @IBOutlet weak var examTitleLabel: UITextField!
    weak var delegate: AddExamCellDelegate?
    var typeArray = [String]()
    var subjectArray = [String]()
    var levelArray = [String]()
    var majorArray = [String]()
    var teacherArray = [String]()
    var teacherID = ""
    var typeID = ""
    var subjectID = ""
    var majorID = ""
    var levelID = ""
    var teacherObj: ExamTeacherList? {
        didSet {
            teacherConfig()
        }
    }
    var subjectObj : ExamSubjectListModel? {
        didSet{
            subjectConfig()
        }
    }
    var levelObj : ExamLevelListModel?{
        didSet{
            levelConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        examTypeButton.addTarget(self, action: #selector(showExamTypePicker), for: .touchUpInside)
        examSubjectButton.addTarget(self, action: #selector(showExamSubjectPicker), for: .touchUpInside)
        examLevelButton.addTarget(self, action: #selector(showExamLevelPicker), for: .touchUpInside)
        examMajorButton.addTarget(self, action: #selector(showMajorPicker), for: .touchUpInside)
        examTeacherButton.addTarget(self, action: #selector(showTeacherPicker), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func teacherConfig() {
        guard let obj = teacherObj else { return }
        teacherArray.removeAll()
        teacherArray = obj.teacherList.map({$0.teacher_name})
    }
    func subjectConfig() {
        guard let obj = subjectObj else { return }
        subjectArray.removeAll()
        subjectArray = obj.subjectList.map({$0.subject_name})
        typeArray.removeAll()
        typeArray = obj.typeList.map({$0.exam_type_name})
    }
    func levelConfig() {
        guard let obj = levelObj else { return }
        levelArray.removeAll()
        levelArray = obj.levelList.map({$0.school_level})
        majorArray.removeAll()
        majorArray = obj.majorList.map({$0.school_major})
    }
    @objc func showTeacherPicker(){
        guard let obj = teacherObj else { return }
        ActionSheetStringPicker.show(
            withTitle: "- Select Teacher -",
            rows: teacherArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.examTeacherButton.setTitle(value, for: .normal)
                self.teacherID = obj.teacherList[indexes].teacher_id
                self.delegate?.teacherSelected(with: self.teacherID)
                self.shouldFetchSubject()
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    
    @objc func showExamTypePicker() {
        guard let obj = subjectObj else { return }
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: typeArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.examTypeButton.setTitle(value, for: .normal)
                self.typeID = obj.typeList[indexes].exam_type_id
                self.delegate?.typeSelectedWithValue(value: self.typeID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    
    @objc func showExamSubjectPicker() {
        guard let obj = subjectObj else { return }
        ActionSheetStringPicker.show(
            withTitle: "- Select Subject -",
            rows: subjectArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.examSubjectButton.setTitle(value, for: .normal)
                self.subjectID = obj.subjectList[indexes].subject_id
                self.delegate?.subjectSelectedWithValue(value: self.subjectID)
                self.shouldFetchLevel()
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    
    @objc func showExamLevelPicker() {
        guard let obj = levelObj else { return }
        ActionSheetStringPicker.show(
            withTitle: "- Select Level -",
            rows: levelArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.examLevelButton.setTitle(value, for: .normal)
                self.levelID = obj.levelList[indexes].school_level_id
                self.delegate?.levelSelectedWithValue(value: self.levelID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    
    @objc func showMajorPicker() {
        guard let obj = levelObj else {return}
        ActionSheetStringPicker.show(
            withTitle: "- Select Major -",
            rows: majorArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.examMajorButton.setTitle(value, for: .normal)
                self.majorID = obj.majorList[indexes].school_major_id
                self.delegate?.majorSelectedWithValue(value: self.majorID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    
    func shouldFetchSubject(){
        //TODO : Change value of School ID and YearID
        if !teacherID.isEmpty{
            ACRequest.POST_GET_EXAM_GET_SUBJECT(
                userID: ACData.LOGINDATA.userID,
                schoolID: ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
                yearID: ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
                school_user_id: teacherID,
                tokenAccess: ACData.LOGINDATA.accessToken,
                successCompletion: { (data) in
                    ACData.EXAMSUBJECTLIST = data
                    self.subjectObj = data
                    SVProgressHUD.dismiss()
            }) { (message) in
                SVProgressHUD.dismiss()
            }
        }
    }
    
    func shouldFetchLevel(){
        //TODO : Change value of School ID and YearID
        if !subjectID.isEmpty && !teacherID.isEmpty{
            ACRequest.POST_GET_EXAM_GET_LEVEL(
                userID: ACData.LOGINDATA.userID,
                schoolID: ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
                yearID: ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
                school_user_id: teacherID,
                subjectID: subjectID,
                tokenAccess: ACData.LOGINDATA.accessToken,
                successCompletion: { (data) in
                    ACData.EXAMLEVELLIST = data
                    self.levelObj = data
                    SVProgressHUD.dismiss()
            }) { (message) in
                SVProgressHUD.dismiss()
            }
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }

    func textViewDidEndEditing(_ textView: UITextView) {
        self.delegate?.descFilledWithValue(value: textView.text!)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.delegate?.descFilledWithValue(value: text)
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.delegate?.titleFilledWithValue(value: textField.text!)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.delegate?.titleFilledWithValue(value: textField.text!)
        return true
    }
    
}
