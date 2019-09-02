//
//  EditExamTopCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 25/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol EditExamTopCellDelegate: class {
    func examTitleFilledWithValue(value: String)
    func examDescFilledWithValue(value: String)
    func examClassFilledWithValue(value: String)
    func examSessionFilledWithValue(value: [ExamSessionWeekSelectedModel])
}

class EditExamTopCell: UITableViewCell {

    @IBOutlet weak var examSessionWeekCollection: UICollectionView!
    @IBOutlet weak var examSessionWeekButton: UIButton!
    @IBOutlet weak var examSessionBgView: UIView! {
        didSet {
            examSessionBgView.layer.borderColor = UIColor.lightGray.cgColor
            examSessionBgView.layer.borderWidth = 1.0
            examSessionBgView.layer.cornerRadius = 5.0
            examSessionBgView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var examTeacherButton: UIButton!
    @IBOutlet weak var examClassButton: UIButton!
    @IBOutlet weak var examMajorButton: UIButton!
    @IBOutlet weak var examLevelButton: UIButton!
    @IBOutlet weak var examSubjectButton: UIButton!
    @IBOutlet weak var examTypeButton: UIButton!
    @IBOutlet weak var examDescLabel: UITextView!
    @IBOutlet weak var examTitleLabel: UITextField!
    var sessionWeekSelected = [ExamSessionWeekSelectedModel]()
    var sessionWeekName = [String]()
    var classArray = [String]()
    var sessionCount = 0
    var selectedWeekIndex = 0
    var currentSelectedWeek = 0
    weak var delegate: EditExamTopCellDelegate?
    var detailObj: ExamEditModel? {
        didSet {
            cellConfig()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        examSessionWeekButton.addTarget(self, action: #selector(showSessionWeekPicker), for: .touchUpInside)
        examSessionWeekCollection.register(UINib(nibName: "EditExamSessionCollectionCell", bundle: nil), forCellWithReuseIdentifier: "editExamSessionCollectionCellID")
        examClassButton.addTarget(self, action: #selector(showExamClassPicker), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func cellConfig() {
        guard let obj = detailObj else { return }
        examTitleLabel.text = obj.exam_title
        examDescLabel.text = obj.exam_desc
        examSubjectButton.setTitle(obj.subject_name, for: .normal)
        examLevelButton.setTitle(obj.school_level, for: .normal)
        examMajorButton.setTitle(obj.school_major, for: .normal)
        examTeacherButton.setTitle(obj.examTeacher.first(where: {$0.teacher_id == obj.teacher_id})?.teacher_name, for: .normal)
//        if obj.examClass.count != 0 {
//            examClassButton.setTitle(obj.examClass[0].school_class, for: .normal)
//        }
        for item in obj.sessionWeek {
            sessionWeekName.append("Week \(item.week_count)(\(item.from_date) - \(item.end_date))")
        }
        for item in obj.examClass {
            classArray.append(item.school_class)
        }
    }
    @objc func showExamClassPicker() {
        guard let obj = detailObj else { return }
        ActionSheetStringPicker.show(
            withTitle: "- Select Class -",
            rows: classArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.examClassButton.setTitle(value, for: .normal)
                let selectedClassID = obj.examClass[indexes].school_class_id
                self.delegate?.examClassFilledWithValue(value: selectedClassID)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )

    }
    @objc func showSessionWeekPicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Week -",
            rows: sessionWeekName,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.examSessionWeekButton.setTitle(value, for: .normal)
                self.selectedWeekIndex = indexes
                self.sessionCount = ACData.EXAMEDITDATA.sessionWeek[indexes].sessions.count
                self.currentSelectedWeek = ACData.EXAMEDITDATA.sessionWeek[indexes].week_count
                // Sorting & Mapping //
                guard let obj = self.detailObj else { return }
                for item in ACData.EXAMEDITDATA.sessionWeek[indexes].sessions {
                    if self.sessionWeekSelected.contains(where: {$0.week_count == obj.sessionWeek[indexes].week_count && $0.session_count == item.session_count}) {
                    } else {
                        self.sessionWeekSelected.append(ExamSessionWeekSelectedModel(sessionCount: item.session_count, isChecked: item.is_checked, weekCount: obj.sessionWeek[indexes].week_count))
                        print(self.sessionWeekSelected)
                    }
                }
                self.examSessionWeekCollection.reloadData()
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
}

extension EditExamTopCell: UICollectionViewDelegate, UICollectionViewDataSource, EditExamSessionCollectionCellDelegate {
    func sessionClickedAt(week: Int, session: Int, checked: Bool) {
        if sessionWeekSelected.contains(where: {$0.week_count == week && $0.session_count == session}) {
            if let index = sessionWeekSelected.index(where: {$0.week_count == week && $0.session_count == session}) {
                sessionWeekSelected[index].is_checked = checked
            }
            self.delegate?.examSessionFilledWithValue(value: sessionWeekSelected)
            examSessionWeekCollection.reloadData()
        } else {

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sessionCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "editExamSessionCollectionCellID", for: indexPath) as? EditExamSessionCollectionCell)!
//        cell.detailObj =
//        cell.currentWeek = self.currentSelectedWeek
        if sessionWeekSelected.contains(where: {$0.week_count == currentSelectedWeek && $0.session_count == ACData.EXAMEDITDATA.sessionWeek[selectedWeekIndex].sessions[indexPath.row].session_count}) {
            if let index = sessionWeekSelected.index(where: {$0.week_count == currentSelectedWeek && $0.session_count == ACData.EXAMEDITDATA.sessionWeek[selectedWeekIndex].sessions[indexPath.row].session_count}) {
                if sessionWeekSelected[index].is_checked {
                    cell.sessionImageStatus.image = UIImage(named: "radio-on-button")
                } else {
                    cell.sessionImageStatus.image = UIImage(named: "circumference")
                }
            }
        } else {

        }
        //
        if let obj = detailObj {
            cell.detailObj = obj.sessionWeek[selectedWeekIndex].sessions[indexPath.row]
        }
        cell.currentWeek = self.currentSelectedWeek
        //        cell.index = indexPath.row
        cell.delegate = self

        return cell
    }
}

extension EditExamTopCell: UITextFieldDelegate, UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        self.delegate?.examDescFilledWithValue(value: textView.text!)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.delegate?.examDescFilledWithValue(value: text)
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.delegate?.examTitleFilledWithValue(value: textField.text!)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.delegate?.examTitleFilledWithValue(value: textField.text!)
        return true
    }
}
