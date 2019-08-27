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
}

class AddExamCell: UITableViewCell, UITextFieldDelegate, UITextViewDelegate/*, UICollectionViewDelegate, UICollectionViewDataSource*/ {

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
    var subjectSelected = ""
    var levelSelected = ""
    var detailObj: ExamTypeModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        examTypeButton.addTarget(self, action: #selector(showExamTypePicker), for: .touchUpInside)
        examSubjectButton.addTarget(self, action: #selector(showExamSubjectPicker), for: .touchUpInside)
        examLevelButton.addTarget(self, action: #selector(showExamLevelPicker), for: .touchUpInside)
        examMajorButton.addTarget(self, action: #selector(showMajorPicker), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        for item in obj.exam_type {
            typeArray.append(item.exam_type_name)
        }
        for item in obj.exam_subject {
            subjectArray.append(item.subject_name)
        }
        for item in obj.exam_level {
            levelArray.append(item.school_level)
        }
    }
    
    @objc func showExamTypePicker() {
        guard let obj = detailObj else { return }
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: typeArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.examTypeButton.setTitle(value, for: .normal)
                let examTypeID = obj.exam_type[indexes].exam_type_id
                self.delegate?.typeSelectedWithValue(value: examTypeID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    
    @objc func showExamSubjectPicker() {
        guard let obj = detailObj else { return }
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: subjectArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.examSubjectButton.setTitle(value, for: .normal)
                let examSubjectID = obj.exam_subject[indexes].subject_id
                self.delegate?.subjectSelectedWithValue(value: examSubjectID)
                self.subjectSelected = examSubjectID
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    
    @objc func showExamLevelPicker() {
        guard let obj = detailObj else { return }
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: levelArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.examLevelButton.setTitle(value, for: .normal)
                let examLevelID = obj.exam_level[indexes].school_level_id
                self.delegate?.levelSelectedWithValue(value: examLevelID)
                self.levelSelected = examLevelID
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    
    @objc func showMajorPicker() {
        if subjectSelected == "" || levelSelected == "" {
            ACAlert.show(message: "Please select both Subject and Level to get Major")
        } else {
            ACRequest.POST_EXAM_MAJOR_LIST(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, schoolLevelID: self.levelSelected, subjectID: self.subjectSelected, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
                SVProgressHUD.dismiss()
                ACData.EXAMMAJORLISTDATA = jsonDatas
                self.populateAndShowPickerForMajor()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        }
    }
    
    func populateAndShowPickerForMajor() {
        for item in ACData.EXAMMAJORLISTDATA.exam_major {
            majorArray.append(item.school_major)
        }
        ActionSheetStringPicker.show(
            withTitle: "- Select Type -",
            rows: majorArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.examMajorButton.setTitle(value, for: .normal)
                let examMajorID = ACData.EXAMMAJORLISTDATA.exam_major[indexes].school_major_id
                self.delegate?.majorSelectedWithValue(value: examMajorID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
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
