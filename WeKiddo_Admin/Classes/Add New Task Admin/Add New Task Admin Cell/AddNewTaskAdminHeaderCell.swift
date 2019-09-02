//
//  AddNewTaskAdminHeaderCell.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 01/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
import ActionSheetPicker_3_0

protocol AddNewTaskAdminHeaderCellDelegate: class {
    func dateFilled(withDate: String)
    func descFilled(withDesc: String)
}

class AddNewTaskAdminHeaderCell: UITableViewCell {

    @IBOutlet weak var taskDescription: UITextView!
    @IBOutlet weak var taskDateButton: UIButton!
    var feedbackDesc = ""
    var placeholderLabel = UILabel()
    weak var delegate: AddNewTaskAdminHeaderCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskDateButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func showDatePicker() {
        ActionSheetDatePicker.show(
            withTitle: "- Select Date -",
            datePickerMode: .date,
            selectedDate: Date(),
            doneBlock: { picker, selectedDate, origin in
                let dateFormatter = DateFormatter()
                let locale = Locale(identifier: "id")
                dateFormatter.dateFormat = "dd/MM/yyyy"
                dateFormatter.locale = locale
                let selectedDates = dateFormatter.string(from: selectedDate as! Date)
                self.taskDateButton.setTitle(selectedDates, for: .normal)
                self.delegate?.dateFilled(withDate: selectedDates)
        }, cancel: nil, origin: self)
    }
}

extension AddNewTaskAdminHeaderCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            feedbackDesc = text
            self.delegate?.descFilled(withDesc: text)
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
        feedbackDesc = textView.text!
        self.delegate?.descFilled(withDesc: textView.text!)
        if textView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !taskDescription.text.isEmpty
    }
}
