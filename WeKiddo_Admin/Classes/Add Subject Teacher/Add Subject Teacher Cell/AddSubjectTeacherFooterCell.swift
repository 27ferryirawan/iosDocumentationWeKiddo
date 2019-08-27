//
//  AddSubjectTeacherFooterCell.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 14/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol AddSubjectTeacherFooterCellDelegate: class {
    func saveSubjectTopicAction()
    func isExamValue(withValue: Bool)
    func isExamTypeFilled(withValue: String)
    func isExamDescFilled(withValue: String)
}

class AddSubjectTeacherFooterCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var examDescription: UITextView!
    @IBOutlet weak var examButton: UIButton!
    @IBOutlet weak var switchExamButton: UISwitch!
    weak var delegate: AddSubjectTeacherFooterCellDelegate?
    var examTypeArray = ["Daily Exam", "Mid Exam", "Final Exam", "Practical Exam", "Others"]
    var isExam = false {
        didSet {
            switchExamButton.isOn = isExam
            if !isExam {
                examDescription.isUserInteractionEnabled = false
                examButton.isUserInteractionEnabled = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        examButton.addTarget(self, action: #selector(showExamTypePicker), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func setIsExam(_ sender: UISwitch) {
        if sender.isOn {
            isExam = true
            examDescription.isUserInteractionEnabled = true
            examButton.isUserInteractionEnabled = true
        } else {
            isExam = false
            examDescription.isUserInteractionEnabled = false
            examButton.isUserInteractionEnabled = false
        }
        self.delegate?.isExamValue(withValue: isExam)
    }
    @objc func showExamTypePicker() {
        ActionSheetStringPicker.show(
            withTitle: "- Select Exam Type -",
            rows: examTypeArray,
            initialSelection: 0,
            doneBlock: { picker, indexes, values in
                guard let value = values as? String else { return }
                self.examButton.setTitle(value, for: .normal)
                self.delegate?.isExamTypeFilled(withValue: value)
        },
            cancel: { ActionMultipleStringCancelBlock in return },
            origin:UIApplication.shared.keyWindow
        )
    }
    @objc func saveAction() {
        self.delegate?.saveSubjectTopicAction()
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
            textView.text = "Reason"
            textView.textColor = UIColor.lightGray
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.isExamDescFilled(withValue: textView.text!)
    }
}
