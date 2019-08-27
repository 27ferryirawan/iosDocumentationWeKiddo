//
//  EditExamViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 25/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SVProgressHUD
import Alamofire

class EditExamViewController: UIViewController {

    @IBOutlet weak var saveEditExamButton: UIButton!
    @IBOutlet weak var remediSaveButton: UIButton!
    @IBOutlet weak var remediDescText: UITextView!
    @IBOutlet weak var remediDateButton: UIButton!
    @IBOutlet weak var remediTitleText: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var remediHeaderLabel: UILabel!
    @IBOutlet weak var remediView: UIView! {
        didSet {
            remediView.layer.borderColor = UIColor.lightGray.cgColor
            remediView.layer.borderWidth = 1.0
            remediView.layer.cornerRadius = 5.0
            remediView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.setBorderShadow(color: UIColor.lightGray, shadowRadius: 2.0, shadowOpactiy: 1.0, shadowOffsetWidth: 2, shadowOffsetHeight: 2)
        }
    }
    var relatedCount = 0
    var remediCount = 0
    var isShowRemediView = false
    var examRemediID = ""
    var examRemediDate = ""
    var examTitle = ""
    var examDesc = ""
    var examSelectedClass = ""
    var sessionSelected = [ExamSessionWeekSelectedModel]()
    var classSelectedArray = [String]()
    var isEditRemedi = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        populateData()
        configTable()
        updateView(withIndex: 0)
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Edit Exam", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func populateData() {
        relatedCount = ACData.EXAMEDITDATA.examRelated.count
        remediCount = ACData.EXAMEDITDATA.examRemedy.count
    }
    func configTable() {
        tableView.register(UINib(nibName: "EditExamTopCell", bundle: nil), forCellReuseIdentifier: "editExamTopCellID")
        tableView.register(UINib(nibName: "EditExamSectionCell", bundle: nil), forCellReuseIdentifier: "editExamSectionCellID")
        tableView.register(UINib(nibName: "EditExamRelatedCell", bundle: nil), forCellReuseIdentifier: "editExamRelatedCellID")
        tableView.register(UINib(nibName: "EditExamRemediScheduleCell", bundle: nil), forCellReuseIdentifier: "editExamRemediScheduleCellID")
        remediDateButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(dismissRemediView), for: .touchUpInside)
        remediSaveButton.addTarget(self, action: #selector(saveRemediAction), for: .touchUpInside)
        saveEditExamButton.addTarget(self, action: #selector(saveExamAction), for: .touchUpInside)
    }
    func updateView(withIndex: Int) {
        if isShowRemediView {
            remediView.isHidden = false
            isShowRemediView = false
            if isEditRemedi {
                remediDescText.text = ACData.EXAMEDITDATA.examRemedy[withIndex].remarks
                remediDateButton.setTitle(ACData.EXAMEDITDATA.examRemedy[withIndex].remedy_date, for: .normal)
                remediTitleText.text = ACData.EXAMEDITDATA.examRemedy[withIndex].title
            } else {
                
            }
        } else {
            remediView.isHidden = true
            isShowRemediView = true
        }
    }
    @objc func saveRemediAction() {
        saveRemediData()
    }
    func saveRemediData() {
        ACRequest.POST_EXAM_ADD_REMEDY(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, examRemedyID: examRemediID, title: remediTitleText.text!, remedyDate: examRemediDate, remarks: remediDescText.text!, examID: ACData.EXAMEDITDATA.school_session_exam_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func dismissRemediView() {
        isShowRemediView = false
        updateView(withIndex: 0)
    }
    @objc func showDatePicker() {
        ActionSheetDatePicker.show(
            withTitle: "- Select Date -",
            datePickerMode: .date,
            selectedDate: Date(),
            doneBlock: { picker, selectedDate, origin in
                let dateFormatter = DateFormatter()
                let dateFormatter2 = DateFormatter()
                let locale = Locale(identifier: "id")
                dateFormatter.dateFormat = "dd/MM/yyyy"
                dateFormatter2.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = locale
                dateFormatter2.locale = locale
                let selectedDates = dateFormatter.string(from: selectedDate as! Date)
                let choosenDate = dateFormatter2.string(from: selectedDate as! Date)
                self.examRemediDate = choosenDate
                self.remediDateButton.setTitle(selectedDates, for: .normal)
        }, cancel: nil, origin: self.view)
    }
    @objc func saveExamAction() {
        var addClassOn = "["
        addClassOn += "{"
        addClassOn += "\"class_id\":\"\(examSelectedClass)\""
        addClassOn += "}"
        addClassOn += "]"

        var addSessionOn = "["
        if sessionSelected.count != 0 {
            var i = 0
            for data in sessionSelected {
                if i > 0 {
                    addSessionOn += ","
                }
                addSessionOn += "{"
                addSessionOn += "\"session_count\":\"\(data.session_count)\","
                addSessionOn += "\"week_count\":\"\(data.week_count)\""
                addSessionOn += "}"
                
                i += 1
            }
        }
        addSessionOn += "]"
        
        let newAddSessionOn = addSessionOn.replacingOccurrences(of: "\\", with: "")
        let jsonSessionData = newAddSessionOn.data(using: .utf8)!
        let jsonSession = try! JSONSerialization.jsonObject(with: jsonSessionData, options: .allowFragments)
        
        let newAddClassOn = addClassOn.replacingOccurrences(of: "\\", with: "")
        let jsonClassData = newAddClassOn.data(using: .utf8)!
        let jsonClass = try! JSONSerialization.jsonObject(with: jsonClassData, options: .allowFragments)
        
        
        print("schoolId: \(ACData.LOGINDATA.school_id), userId: \(ACData.LOGINDATA.userID), role: \(ACData.LOGINDATA.role), yearId: \(ACData.LOGINDATA.year_id), examID: \(""), examTitle: \(examTitle), examDesc: \(examDesc), examTypeID: \(ACData.EXAMEDITDATA.exam_type_id), subjectID: \(ACData.EXAMEDITDATA.subject_id), class: \(jsonClass), session: \(jsonSession)")
        
        if examTitle == "" {
            examTitle = ACData.EXAMEDITDATA.exam_title
        } else {
            
        }
        
        if examDesc == "" {
            examDesc = ACData.EXAMEDITDATA.exam_desc
        } else {
            
        }
        
        let parameters: Parameters = [
            "school_id":ACData.LOGINDATA.school_id,
            "year_id":ACData.LOGINDATA.year_id,
            "user_id":ACData.LOGINDATA.userID,
            "role":ACData.LOGINDATA.role,
            "exam_id":ACData.EXAMEDITDATA.school_session_exam_id,
            "exam_title":examTitle,
            "exam_desc":examDesc,
            "exam_type_id":ACData.EXAMEDITDATA.exam_type_id,
            "subject_id":ACData.EXAMEDITDATA.subject_id,
            "class":jsonClass,
            "sessioncounts":jsonSession
        ]
        
        ACRequest.POST_ADD_NEW_EXAM(params: parameters, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension EditExamViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 + relatedCount + remediCount
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 645
        } else if indexPath.row == 1 {
            return 33
        } else if indexPath.row < 2 + relatedCount {
            return 44
        } else if indexPath.row == 2 + relatedCount {
            return 33
        } else {
            return 44
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "editExamTopCellID", for: indexPath) as? EditExamTopCell)!
            cell.detailObj = ACData.EXAMEDITDATA
            cell.delegate = self
            return cell
        } else if indexPath.row == 1 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "editExamSectionCellID", for: indexPath) as? EditExamSectionCell)!
            cell.config(isRelated: true)
            return cell
        } else if indexPath.row < 2 + relatedCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "editExamRelatedCellID", for: indexPath) as? EditExamRelatedCell)!
            cell.detailObj = ACData.EXAMEDITDATA.examRelated[indexPath.row-2]
            return cell
        } else if indexPath.row == 2 + relatedCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "editExamSectionCellID", for: indexPath) as? EditExamSectionCell)!
            cell.delegate = self
            cell.config(isRelated: false)
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "editExamRemediScheduleCellID", for: indexPath) as? EditExamRemediScheduleCell)!
            cell.detailObj = ACData.EXAMEDITDATA.examRemedy[indexPath.row - (3+relatedCount)]
            cell.index = indexPath.row - (3+relatedCount)
            cell.delegate = self
            return cell
        }
    }
}

extension EditExamViewController: EditExamRemediScheduleCellDelegate, EditExamSectionCellDelegate, EditExamTopCellDelegate {
    func examTitleFilledWithValue(value: String) {
        print(value)
        if value == "" {
            examTitle = ACData.EXAMEDITDATA.exam_title
        } else {
            examTitle = value
        }
    }
    
    func examDescFilledWithValue(value: String) {
        if value == "" {
            examDesc = ACData.EXAMEDITDATA.exam_desc
        } else {
            examDesc = value
        }
    }
    
    func examClassFilledWithValue(value: String) {
        examSelectedClass = value
    }
    
    func examSessionFilledWithValue(value: [ExamSessionWeekSelectedModel]) {
        sessionSelected = value
    }
    
    func showEditRemediView(withIndex: Int) {
        isShowRemediView = true
        isEditRemedi = true
        examRemediID = ACData.EXAMEDITDATA.examRemedy[withIndex].exam_remedy_id
        updateView(withIndex: withIndex)
    }
    func showAddRemediView() {
        isShowRemediView = true
        isEditRemedi = false
        examRemediID = ""
        updateView(withIndex: 0)
    }
}

extension EditExamViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
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
            textView.text = "Desc"
            textView.textColor = UIColor.lightGray
        }
    }
    func textViewDidChange(_ textView: UITextView) {

    }
}

